output "config_name" {
  value = "${aws_config_configuration_recorder.config.id}"
}

output "config_role_arn" {
  value = "${aws_config_configuration_recorder.config.role_arn}"
}

output "config_recorder_id" {
  value = "${aws_config_configuration_recorder_status.config.id}"
}

output "config_recorder_is_enabled" {
  value = "${aws_config_configuration_recorder_status.config.is_enabled}"
}

output "config_delivery_channel_id" {
  value = "${aws_config_delivery_channel.config.id}"
}

output "config_delivery_channel_bucket_name" {
  value = "${aws_config_delivery_channel.config.s3_bucket_name}"
}
