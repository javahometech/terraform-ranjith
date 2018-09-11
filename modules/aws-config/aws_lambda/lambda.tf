# aws_lambda
data "aws_caller_identity" "current" {}

data "template_file" "aws_lambda" {
  template = "/dev/null"

  vars {
    lambda_function_name = "${length(var.lambda_function_name) == 0 ?
                     format("%s%s",
                           format("%s", "default"),
                           length(var.name_space) == 0 ?
                             format("%s", "" )
                             :
                             format("-%s", var.name_space )
                           )
                     :
                     format("%s%s",
                           format("%s", var.lambda_function_name),
                           length(var.name_space) == 0 ?
                             format("%s", "" )
                             :
                             format("-%s", var.name_space )
                           )
                     }"

    lambda_description = "${length(var.lambda_description) == 0 ?
                             format("%s", "default-description")
                             :
                             format("%s", var.lambda_description)
                           }"

    lambda_filename_zip = "${var.lambda_filename_zip}"

    # Determine if this lambda module is working with a local or s3 file source
    lambda_file_from_local = "${length(var.lambda_filename_zip) > 0 ? 1 : 0}"

    lambda_file_from_s3 = "${length(var.lambda_filename_zip) > 0 ?  0 : length(var.lambda_file_s3_key_zip) > 0 ? 1 : 0 }"

    lambda_file_s3_bucket = "${var.lambda_file_s3_bucket}"

    lambda_file_s3_key_zip = "${var.lambda_file_s3_key_zip}"

    lambda_file_s3_object_version = "${var.lambda_file_s3_object_version}"

    lambda_runtime = "${lookup(var.lambda_runtime_types, var.lambda_runtime, "python3.6")}"

    lambda_memory_size = "${lookup(var.lambda_memory_sizes, var.lambda_memory_size, "128")}"

    lambda_timeout_sec = "${var.lambda_timeout_sec >= 300 ?
                           300
                           :
                           var.lambda_timeout_sec <= 0 ?
                              3
                              :
                              var.lambda_timeout_sec
                          }"

    lambda_publish = "${var.lambda_publish}"

    lambda_exec_custom_policy_count = "${var.lambda_exec_custom_policy_count}"

    lambda_exec_trigger_count = "${var.lambda_exec_trigger_count}"
  }
}

locals {
  lambda_role_name = "${length(var.lambda_role_name) == 0 ?
                         format("LambdaExec-%s", data.template_file.aws_lambda.vars.lambda_function_name)
                         :
                         format("%s", var.lambda_role_name)
                       }"

  lambda_handler = "${length(var.lambda_handler) == 0 ?
                       format("%s.lambda_handler",
                         data.template_file.aws_lambda.vars.lambda_file_from_local == 1 ?
                           format("%s", element(split(".", basename(data.template_file.aws_lambda.vars.lambda_filename_zip)),0))
                         :
                           format("%s", element(split(".", basename(data.template_file.aws_lambda.vars.lambda_file_s3_key_zip)),0)))
                       :
                       format("%s", var.lambda_handler)
                     }"
}

# Create role with policies that allow the Lambda function to execute
module "lambda-exec-role" {
  source                             = "git::https://github.optum.com/CommercialCloud-EAC/aws_iam.git//terraform_module/role?ref=v1.0.1"
  role_name                          = "${local.lambda_role_name}"
  role_assumerole_service_principals = ["lambda.amazonaws.com"]
  role_custom_managed_policy_count   = 1
  role_custom_managed_policy         = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  role_custom_inline_policy_count    = "${data.template_file.aws_lambda.vars.lambda_exec_custom_policy_count}"
  role_custom_inline_policy          = ["${var.lambda_exec_custom_policy}"]

  global_tags = {
    global_tag = "${var.global_tags}"
  }
}

# If using zip file; run this terraform block
resource "aws_lambda_function" "from_local" {
  count            = "${data.template_file.aws_lambda.vars.lambda_file_from_local}"
  filename         = "${data.template_file.aws_lambda.vars.lambda_filename_zip}"
  source_code_hash = "${base64sha256(file(data.template_file.aws_lambda.vars.lambda_filename_zip))}"
  function_name    = "${data.template_file.aws_lambda.vars.lambda_function_name}"
  description      = "${data.template_file.aws_lambda.vars.lambda_description}"
  handler          = "${local.lambda_handler}"
  role             = "${module.lambda-exec-role.role_arn}"
  runtime          = "${data.template_file.aws_lambda.vars.lambda_runtime}"
  memory_size      = "${data.template_file.aws_lambda.vars.lambda_memory_size}"
  timeout          = "${data.template_file.aws_lambda.vars.lambda_timeout_sec}"
  publish          = "${data.template_file.aws_lambda.vars.lambda_publish}"

  environment {
    variables = "${var.lambda_environment_vars}"
  }

  tags = "${merge(var.global_tags, var.lambda_tags, map("file_from_local", substr(data.template_file.aws_lambda.vars.lambda_filename_zip, -(length(data.template_file.aws_lambda.vars.lambda_filename_zip) > 256 ? 256 : length(data.template_file.aws_lambda.vars.lambda_filename_zip)), (length(data.template_file.aws_lambda.vars.lambda_filename_zip) > 256 ? 256 : length(data.template_file.aws_lambda.vars.lambda_filename_zip)) )) )}"

  vpc_config = {
    subnet_ids         = "${var.lambda_subnet_ids}"
    security_group_ids = "${var.lambda_security_group_ids}"
  }
}

# If using s3 file; run this terraform block
# There is an issue with attribute source_code_hash when using files from s3 buckets
# https://github.com/hashicorp/terraform/issues/6513
# Until this issue has been fixed, source_code_hash will not be used when reading files from s3 buckets
# Instead the s3_object_version attribute is used to trigger a change with files in s3 buckets
resource "aws_lambda_function" "from_s3" {
  count             = "${data.template_file.aws_lambda.vars.lambda_file_from_s3}"
  s3_bucket         = "${data.template_file.aws_lambda.vars.lambda_file_s3_bucket}"
  s3_key            = "${data.template_file.aws_lambda.vars.lambda_file_s3_key_zip}"
  s3_object_version = "${data.template_file.aws_lambda.vars.lambda_file_s3_object_version}"
  function_name     = "${data.template_file.aws_lambda.vars.lambda_function_name}"
  description       = "${data.template_file.aws_lambda.vars.lambda_description}"
  handler           = "${local.lambda_handler}"
  role              = "${module.lambda-exec-role.role_arn}"
  runtime           = "${data.template_file.aws_lambda.vars.lambda_runtime}"
  memory_size       = "${data.template_file.aws_lambda.vars.lambda_memory_size}"
  timeout           = "${data.template_file.aws_lambda.vars.lambda_timeout_sec}"
  publish           = "${data.template_file.aws_lambda.vars.lambda_publish}"

  environment {
    variables = "${var.lambda_environment_vars}"
  }

  tags = "${merge(var.global_tags, var.lambda_tags, map("file_from_s3", format("%.256s", format("%s:%s", data.template_file.aws_lambda.vars.lambda_file_s3_bucket, data.template_file.aws_lambda.vars.lambda_file_s3_key_zip))) )}"

  vpc_config = {
    subnet_ids         = "${var.lambda_subnet_ids}"
    security_group_ids = "${var.lambda_security_group_ids}"
  }
}

# Create permissions to execute lambda if provided
resource "aws_lambda_permission" "triggers" {
  count         = "${data.template_file.aws_lambda.vars.lambda_exec_trigger_count}"
  statement_id  = "${lookup(var.lambda_exec_triggers[count.index], "trigger_id")}"
  action        = "lambda:InvokeFunction"
  function_name = "${join(",",concat(aws_lambda_function.from_local.*.function_name,aws_lambda_function.from_s3.*.function_name))}"
  principal     = "${lookup(var.lambda_exec_triggers[count.index], "trigger_principal")}"
  source_arn    = "${lookup(var.lambda_exec_triggers[count.index], "trigger_source_arn")}"
}
