# AWS Config initialize module
data "aws_caller_identity" "current" {}

data "template_file" "config" {
  template = "/dev/null"

  vars {
    config_name = "${length(var.config_name) == 0 ?
                       format("%s%s",
                           length(var.config_name) == 0 ?
                             format("%s", "default")
                             :
                             format("%s", var.config_name ),
                           length(var.name_space) == 0 ?
                             format("%s", "" )
                             :
                             format("-%s", var.name_space )
                           )
      :
      format("%s", length(var.name_space) == 0 ?
                   format("%s", var.config_name)
                   :
                   format("%s-%s", var.config_name, var.name_space)
            )
      }"

    s3_bucket_name = "${length(var.config_s3_bucket) == 0 ?
      format("%s", length(var.config_name) == 0 ?
         (length(var.name_space) == 0 ?
             format("%s-config-%s",data.aws_caller_identity.current.account_id,"default")
             :
             format("%s-config-%s-%s",data.aws_caller_identity.current.account_id,"default",var.name_space))
         :
         (length(var.name_space) == 0
             ?
             format("%s-config-%s",data.aws_caller_identity.current.account_id,var.config_name)
             :
             format("%s-config-%s-%s",data.aws_caller_identity.current.account_id,var.config_name,var.name_space)))
      :
      format("%s", length(var.name_space) == 0 ?
         format("%s", var.config_s3_bucket)
         :
         format("%s-%s", var.config_s3_bucket, var.name_space))
      }"

    name_space                 = "${length(var.name_space) == 0 ? format("%s", "") : var.name_space}"
    config_force_destroy       = "${var.config_force_destroy}"
    config_recorder_is_enabled = "${var.config_recorder_is_enabled}"
  }
}

locals {
  role_name = "${length(var.config_full_control_role_name) == 0 ?
             format("%s-%s","AWS-Config-FullControl",data.template_file.config.vars.config_name)
             :
             format("%s",var.config_full_control_role_name)
             }"
}

# Create a FullControl role to manage the AWS Config policies
module "config-s3-bucket-policy" {
  source             = "git::https://github.optum.com/CommercialCloud-EAC/aws_iam.git//terraform_module/policy?ref=v1.0.3"
  policy_name        = "ConfigReadWriteS3Bucket"
  policy_description = "Grants read write access to Config S3 bucket"
  policy_document    = "${data.aws_iam_policy_document.config_s3_put_files.json}"
  name_space         = "${data.template_file.config.vars.name_space}"
}

module "config-role" {
  source                             = "git::https://github.optum.com/CommercialCloud-EAC/aws_iam.git//terraform_module/role?ref=v1.0.3"
  role_name                          = "${local.role_name}"
  role_assumerole_service_principals = ["config.amazonaws.com"]
  role_custom_managed_policy_count   = 2

  role_custom_managed_policy = ["arn:aws:iam::aws:policy/service-role/AWSConfigRole",
    "${module.config-s3-bucket-policy.policy_arn}",
  ]

  global_tags = {
    global_tag = "${var.global_tags}"
  }
}

# Create the AWS Config recorder
resource "aws_config_configuration_recorder" "config" {
  name     = "${data.template_file.config.vars.config_name}"
  role_arn = "${module.config-role.role_arn}"

  recording_group = {
    include_global_resource_types = true
  }
}

# Create the delivery channel for the recorder
resource "aws_config_delivery_channel" "config" {
  name           = "${data.template_file.config.vars.config_name}"
  s3_bucket_name = "${var.config_s3_bucket}"
  depends_on     = ["aws_config_configuration_recorder.config"]
}

# Activate the recorder
resource "aws_config_configuration_recorder_status" "config" {
  name       = "${aws_config_configuration_recorder.config.name}"
  is_enabled = "${data.template_file.config.vars.config_recorder_is_enabled}"
  depends_on = ["aws_config_delivery_channel.config"]
}
