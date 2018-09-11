# AWS Config User module
data "aws_caller_identity" "current" {}

data "template_file" "config_custom_rule" {
  template = "/dev/null"

  vars {
    config_custom_rule_name = "${length(var.config_custom_rule_name) == 0 ?
                             format("%s%s",
                                  length(var.config_custom_rule_name) == 0 ?
                                    format("%s", "default-rule")
                                    :
                                    format("%s", var.config_custom_rule_name ),
                                  length(var.name_space) == 0 ?
                                    format("%s", "" )
                                    :
                                    format("-%s", var.name_space )
                                  )
             :
             format("%s", length(var.name_space) == 0 ?
                          format("%s", var.config_custom_rule_name)
                          :
                          format("%s-%s", var.config_custom_rule_name, var.name_space)
                   )
             }"

    config_custom_rule_description = "${length(var.config_custom_rule_description) == 0 ?
                                        format("%s", "default-description")
                                        :
                                        format("%s", var.config_custom_rule_description)
                                      }"

    config_custom_rule_lambda_filename = "${var.config_custom_rule_lambda_filename}"

    config_custom_rule_lambda_filename_zip = "${format("%s%s", var.config_custom_rule_lambda_filename, ".zip")}"

    config_custom_rule_exec_custom_policy_count = "${var.config_custom_rule_exec_custom_policy_count}"

    config_custom_rule_source_detail_message_type = "${lookup(var.config_custom_rule_source_detail_message_types, var.config_custom_rule_source_detail_message_type, "ScheduledNotification")}"

    config_custom_rule_source_detail_max_execution_freq = "${lookup(var.config_custom_rule_source_detail_max_execution_freqs, var.config_custom_rule_source_detail_max_execution_freq, "TwentyFour_Hours")}"

    name_space = "${length(var.name_space) == 0 ? format("%s", "") : var.name_space}"
  }
}

locals {
  config_custom_rule_lambda_function_name = "${length(var.config_custom_rule_lambda_function_name) == 0 ?
                                        format("%s", data.template_file.config_custom_rule.vars.config_custom_rule_name)
                                        :
                                        format("%s", var.config_custom_rule_lambda_function_name)
                                      }"
}

data "archive_file" "hello-world-compliance" {
  type        = "zip"
  source_file = "${data.template_file.config_custom_rule.vars.config_custom_rule_lambda_filename}"
  output_path = "${path.module}/files/${data.template_file.config_custom_rule.vars.config_custom_rule_lambda_filename_zip}"
}

# Create a lambda function from a local file store in this repository
module "config-rule-lambda" {
  source                          = "git::https://github.optum.com/CommercialCloud-EAC/aws_lambda.git//terraform_module?ref=v1.1.2"
  lambda_function_name            = "${local.config_custom_rule_lambda_function_name}"
  lambda_description              = "${data.template_file.config_custom_rule.vars.config_custom_rule_description}"
  lambda_filename_zip             = "${path.module}/files/${data.template_file.config_custom_rule.vars.config_custom_rule_lambda_filename_zip}"
  lambda_exec_custom_policy_count = "${data.template_file.config_custom_rule.vars.config_custom_rule_exec_custom_policy_count}"
  lambda_exec_custom_policy       = "${var.config_custom_rule_exec_custom_policy}"
  lambda_exec_trigger_count       = 1

  lambda_exec_triggers = [{
    trigger_id         = "AllowExecuteFromConfig"
    trigger_principal  = "config.amazonaws.com"
    trigger_source_arn = ""
  }]

  lambda_tags = "${var.config_custom_rule_tags}"
  global_tags = "${var.global_tags}"
}

# Activate rule using custom lambda function not scoped to a resource(s)
# Needs the var.config_has_scopes == false
resource "aws_config_config_rule" "custom_lambda_rule" {
  count            = "${var.config_is_enabled && !var.config_has_scopes ? 1 : 0}"
  name             = "${data.template_file.config_custom_rule.vars.config_custom_rule_name}"
  description      = "${data.template_file.config_custom_rule.vars.config_custom_rule_description}"
  input_parameters = "${jsonencode(var.config_custom_rule_input_parameters)}"

  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = "${module.config-rule-lambda.lambda_arn}"

    source_detail {
      maximum_execution_frequency = "${data.template_file.config_custom_rule.vars.config_custom_rule_source_detail_max_execution_freq}"
      message_type                = "${data.template_file.config_custom_rule.vars.config_custom_rule_source_detail_message_type}"
    }
  }
}

# Activate a rule using custom lambda function scoped to a resource(s)
# Needs the var.config_has_scopes == true
resource "aws_config_config_rule" "custom_lambda_rule_scoped" {
  count            = "${var.config_is_enabled && var.config_has_scopes ? 1 : 0}"
  name             = "${data.template_file.config_custom_rule.vars.config_custom_rule_name}"
  description      = "${data.template_file.config_custom_rule.vars.config_custom_rule_description}"
  input_parameters = "${jsonencode(var.config_custom_rule_input_parameters)}"

  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = "${module.config-rule-lambda.lambda_arn}"

    source_detail {
      message_type = "${data.template_file.config_custom_rule.vars.config_custom_rule_source_detail_message_type}"
    }
  }

  scope {
    compliance_resource_types = "${var.config_custom_compliance_types}"
  }
}
