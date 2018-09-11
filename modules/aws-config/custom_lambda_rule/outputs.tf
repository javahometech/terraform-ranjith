output "config_custom_rule_arn" {
  value = "${join(",", concat(aws_config_config_rule.custom_lambda_rule.*.arn, aws_config_config_rule.custom_lambda_rule_scoped.*.arn))}"
}

output "config_custom_rule_id" {
  value = "${join(",", concat(aws_config_config_rule.custom_lambda_rule.*.id, aws_config_config_rule.custom_lambda_rule_scoped.*.id))}"
}
