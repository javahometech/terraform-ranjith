# Default variables for the iam module
variable "config_name" {
  description = "Name of the AWS config"
  default     = ""
}

variable "config_s3_bucket" {
  description = "Name of the S3 bucket to store AWS config logs"
  default     = ""
}

variable "config_force_destroy" {
  description = "When destroying Config setup, force all AWS resources to be removed"
  default     = false
}

variable "config_recorder_is_enabled" {
  description = "Flag that activates or deactives the AWS config recorder, default = true"
  default     = true
}

variable "config_full_control_role_name" {
  description = "Role name to manage all of the AWS Config service features"
  default     = ""
}

variable "name_space" {
  description = "Name space for this terraform run"
  default     = ""
}

variable "config_tags" {
  description = "Map of tags to apply to all config resources that have tags parameters"
  type        = "map"
  default     = {}
}

variable "global_tags" {
  description = "Map of tags to apply to all resources that have tags parameters"
  type        = "map"
  default     = {}
}
