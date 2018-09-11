# AWS Config User module to activate AWS managed config rules

# Activate AWS managed rules that are not periodic rules
resource "aws_config_config_rule" "aws_managed_rule" {
  count       = "${var.config_is_enabled ? var.config_aws_managed_rule_count : 0}"
  name        = "${format("%s", lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name"))}"
  description = "${format("%s", lookup(var.config_aws_managed_rules[lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name")], "description" ))}"

  source {
    owner             = "AWS"
    source_identifier = "${format("%s", lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name"))}"
  }

  input_parameters = "${format("{ %s }", coalesce(lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_input_parameters", ""), lookup(var.config_aws_managed_rules[lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name")], "input_parameters", "" ),""))}"

  scope {
    compliance_resource_types = "${compact(concat(split(",", format("%s", lookup(var.config_aws_managed_rules[lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name")], "compliance_resource_types" ))), split(",", format("%s", lookup(var.config_aws_managed_rules[lookup(var.config_aws_managed_rule_activate_list[count.index], "config_rule_name")], "compliance_resource_types_extra" ))))) }"
  }
}

# Activate AWS managed rules that require periodic parameters (non-scoped)
resource "aws_config_config_rule" "aws_managed_periodic_rule" {
  count                       = "${var.config_is_enabled ? var.config_aws_managed_periodic_rule_count : 0}"
  name                        = "${format("%s", lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_name"))}"
  description                 = "${format("%s", lookup(var.config_aws_managed_periodic_rules[lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_name")], "description" ))}"
  maximum_execution_frequency = "${format("%s", coalesce(lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_maximum_execution_frequency", ""), lookup(var.config_aws_managed_periodic_rules[lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_name")], "maximum_execution_frequency", "" ),"TwentyFour_Hours"))}"

  source {
    owner             = "AWS"
    source_identifier = "${format("%s", lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_name"))}"
  }

  input_parameters = "${format("{ %s }", coalesce(lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_input_parameters", ""), lookup(var.config_aws_managed_periodic_rules[lookup(var.config_aws_managed_periodic_rule_activate_list[count.index], "config_rule_name")], "input_parameters", "" ),""))}"
}

# Activate AWS managed rules that require periodic parameters (scoped)
# Only use for ACM_CERTIFICATE_EXPIRATION_CHECK & DYNAMODB_THROUGHPUT_LIMIT_CHECK
resource "aws_config_config_rule" "aws_managed_periodic_scoped_rule" {
  count                       = "${var.config_is_enabled ? var.config_aws_managed_periodic_scoped_rule_count : 0}"
  name                        = "${format("%s", lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name"))}"
  description                 = "${format("%s", lookup(var.config_aws_managed_periodic_scoped_rules[lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name")], "description" ))}"
  maximum_execution_frequency = "${format("%s", coalesce(lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_maximum_execution_frequency", ""), lookup(var.config_aws_managed_periodic_scoped_rules[lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name")], "maximum_execution_frequency", "" ),"TwentyFour_Hours"))}"

  source {
    owner             = "AWS"
    source_identifier = "${format("%s", lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name"))}"
  }

  input_parameters = "${format("{ %s }", coalesce(lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_input_parameters", ""), lookup(var.config_aws_managed_periodic_scoped_rules[lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name")], "input_parameters", "" ),""))}"

  scope {
    compliance_resource_types = "${compact(concat(split(",", format("%s", lookup(var.config_aws_managed_periodic_scoped_rules[lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name")], "compliance_resource_types" ))), split(",", format("%s", lookup(var.config_aws_managed_periodic_scoped_rules[lookup(var.config_aws_managed_periodic_scoped_rule_activate_list[count.index], "config_rule_name")], "compliance_resource_types_extra" ))))) }"
  }
}
