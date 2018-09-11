# Default variables for the config custom rule module
variable "config_is_enabled" {
  description = "Flag indicating that AWS Config is active and recording"
  default     = false
}

variable "config_has_scopes" {
  description = "Determines whether the rule should be scoped: False creates the aws_config_config_rule.custom_lambda_rule, True creates creates the aws_config_config_rule.custom_lambda_rule_scoped"
  default     = false
}

variable "config_custom_compliance_types" {
  description = "List of resources that are scoped to this config rule"
  default     = []
}

variable "config_custom_rule_name" {
  description = "Name of the AWS config custom rule"
  default     = ""
}

variable "config_custom_rule_description" {
  description = "Description of the AWS config custom rule"
  default     = ""
}

variable "config_custom_rule_lambda_function_name" {
  description = "Lambda function name called by the AWS config custom rule"
  default     = ""
}

variable "config_custom_rule_lambda_filename" {
  description = "Filename containing the function source code"
  default     = ""
}

variable "config_custom_rule_exec_custom_policy_count" {
  description = "Number of custom policies to apply to the AWS config custom rule (ie. lambda exec role)"
  default     = 0
}

variable "config_custom_rule_exec_custom_policy" {
  description = "List of custom policies to apply to the AWC config custom rule (ie. lambda exec role)"

  default = [{
    role_custom_inline_policy_name = "null"
    role_custom_inline_policy      = "{\"Version\": \"2012-10-17\",\"Statement\":[]}"
  }]
}

variable "config_custom_rule_input_parameters" {
  description = "List of key / Value pairs that are passed through to Lambda function during execution"
  default     = {}
}

variable "config_custom_rule_source_detail_message_type" {
  description = "Message type of source details when creating a AWS config custom rule"
  default     = ""
}

variable "config_custom_rule_source_detail_message_types" {
  description = "Valid message types of source details when creating a AWS config custom rule"
  type        = "map"

  default = {
    "ConfigurationItemChangeNotification"          = "ConfigurationItemChangeNotification"
    "ConfigurationSnapshotDeliveryCompleted"       = "ConfigurationSnapshotDeliveryCompleted"
    "ScheduledNotification"                        = "ScheduledNotification"
    "OversizedConfigurationItemChangeNotification" = "OversizedConfigurationItemChangeNotification"
  }
}

variable "config_custom_rule_source_detail_max_execution_freq" {
  description = "Frequency of AWS Config to evaluate rule that is triggered periodically"
  default     = ""
}

variable "config_custom_rule_source_detail_max_execution_freqs" {
  description = "Valid frequency of AWS Config to evaluate rule that is triggered periodically"
  type        = "map"

  default = {
    "One_Hour"         = "One_Hour"
    "Three_Hours"      = "Three_Hours"
    "Six_Hours"        = "Six_Hours"
    "Twelve_Hours"     = "Twelve_Hours"
    "TwentyFour_Hours" = "TwentyFour_Hours"
  }
}

variable "name_space" {
  description = "Name space for this terraform run"
  default     = ""
}

variable "config_custom_rule_tags" {
  description = "Map of tags to apply to all config custom rule resources that have tags parameters"
  type        = "map"
  default     = {}
}

variable "global_tags" {
  description = "Map of tags to apply to all resources that have tags parameters"
  type        = "map"
  default     = {}
}
