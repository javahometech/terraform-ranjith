output "aws_config_aws_managed_rule_arns" {
  value = "${join(",", aws_config_config_rule.aws_managed_rule.*.arn)}"
}

output "aws_config_aws_managed_rule_ids" {
  value = "${join(",", aws_config_config_rule.aws_managed_rule.*.id)}"
}

output "aws_config_aws_managed_periodic_rule_arns" {
  value = "${join(",", aws_config_config_rule.aws_managed_periodic_rule.*.arn)}"
}

output "aws_config_aws_managed_periodic_rule_ids" {
  value = "${join(",", aws_config_config_rule.aws_managed_periodic_rule.*.id)}"
}

output "aws_config_aws_managed_periodic_scoped_rule_arns" {
  value = "${join(",", aws_config_config_rule.aws_managed_periodic_scoped_rule.*.arn)}"
}

output "aws_config_aws_managed_periodic_scoped_rule_ids" {
  value = "${join(",", aws_config_config_rule.aws_managed_periodic_scoped_rule.*.id)}"
}
