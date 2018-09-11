# Default variables for the iam module
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  default     = ""
}

variable "lambda_description" {
  description = "Description of what the Lambda function does"
  default     = ""
}

variable "lambda_filename_zip" {
  description = "Filename containing the function source code; must be .zip format"
  default     = ""
}

variable "lambda_file_s3_bucket" {
  description = "S3 bucket name containing the function source code"
  default     = ""
}

variable "lambda_file_s3_key_zip" {
  description = "S3 bucket key containing the function source code; must be .zip format"
  default     = ""
}

variable "lambda_file_s3_object_version" {
  description = "Version of the S3 file containing the function source code"
  default     = ""
}

variable "lambda_role_name" {
  description = "Role name of the role created for the Lambda function to execute"
  default     = ""
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  default     = ""
}

variable "lambda_runtime_types" {
  description = "Types of runtime envrionments for the Lambda function"
  type        = "map"

  default = {
    "nodejs"         = "nodejs"
    "nodejs4.3"      = "nodejs4.3"
    "nodejs6.10"     = "nodejs6.10"
    "java8"          = "java8"
    "python2.7"      = "python2.7"
    "python3.6"      = "python3.6"
    "dotnetcore1.0"  = "dotnetcore1.0"
    "nodejs4.3-edge" = "nodejs4.3-edge"
  }
}

variable "lambda_handler" {
  description = "Runtime environment for the Lambda function"
  default     = ""
}

variable "lambda_memory_sizes" {
  description = "Valid memory sizes in MB to use at runtime; in 64MB increments"
  type        = "map"

  default = {
    "128"  = "128"
    "192"  = "192"
    "256"  = "256"
    "320"  = "320"
    "384"  = "384"
    "448"  = "448"
    "512"  = "512"
    "576"  = "576"
    "640"  = "640"
    "704"  = "704"
    "768"  = "768"
    "832"  = "832"
    "896"  = "896"
    "960"  = "960"
    "1024" = "1024"
    "1088" = "1088"
    "1152" = "1152"
    "1216" = "1216"
    "1280" = "1280"
    "1344" = "1344"
    "1408" = "1408"
    "1472" = "1472"
    "1536" = "1536"
    "1600" = "1600"
    "1664" = "1664"
    "1728" = "1728"
    "1792" = "1792"
    "1856" = "1856"
    "1920" = "1920"
    "1984" = "1984"
    "2048" = "2048"
    "2112" = "2112"
    "2176" = "2176"
    "2240" = "2240"
    "2304" = "2304"
    "2368" = "2368"
    "2432" = "2432"
    "2496" = "2496"
    "2560" = "2560"
    "2624" = "2624"
    "2688" = "2688"
    "2752" = "2752"
    "2816" = "2816"
    "2880" = "2880"
    "2944" = "2944"
    "3008" = "3008"
  }
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB to use at runtime; in 64MB increments"
  default     = ""
}

variable "lambda_timeout_sec" {
  description = "Amount of time (in seconds) to allow the Lambda function to run (maximum 300)"
  default     = "300"
}

variable "lambda_publish" {
  description = "Whether to publish creation/change as new Lambda function version (true/false)"
  default     = "false"
}

# Environment vars can't be null, so set a default; this will get overwritten if passed in
variable "lambda_environment_vars" {
  description = "Mapping of environment variables for the Lambda function (key/value)"
  type        = "map"

  default = {
    default = "default"
  }
}

variable "lambda_exec_custom_policy_count" {
  description = "Number of custom policies to apply to the lambda exec role"
  default     = 0
}

variable "lambda_exec_custom_policy" {
  description = "List of custom policies to apply to the lambda exec role, provides lambda access to AWS resources"

  default = [{
    role_custom_inline_policy_name = "null"
    role_custom_inline_policy      = "{\"Version\": \"2012-10-17\",\"Statement\":[]}"
  }]
}

variable "lambda_exec_trigger_count" {
  description = "Number of execution triggers to apply to the lambda function"
  default     = 0
}

variable "lambda_exec_triggers" {
  description = "List of execution triggers to apply to the lambda function"

  default = [{
    trigger_id         = "default"
    trigger_principal  = "default"
    trigger_source_arn = "arn:aws:iam::123456789012:*"
  }]
}

variable "name_space" {
  description = "Name space for this terraform run"
  default     = ""
}

variable "lambda_tags" {
  description = "Map of tags to apply to all lambda resources that have tags parameters"
  type        = "map"
  default     = {}
}

variable "global_tags" {
  description = "Map of tags to apply to all resources that have tags parameters"
  type        = "map"
  default     = {}
}

variable "lambda_subnet_ids" {
  description = "A list of subnet IDs associated with the Lambda function"
  type        = "list"
  default     = []
}

variable "lambda_security_group_ids" {
  description = "A list of security group IDs associated with the Lambda function"
  type        = "list"
  default     = []
}
