# Compute proper outputs depending on which resource block was active
output "lambda_function_name" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.function_name,aws_lambda_function.from_s3.*.function_name))}"
}

output "lambda_arn" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.arn,aws_lambda_function.from_s3.*.arn))}"
}

output "lambda_qualified_arn" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.qualified_arn,aws_lambda_function.from_s3.*.qualified_arn))}"
}

output "lambda_invoke_arn" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.invoke_arn,aws_lambda_function.from_s3.*.invoke_arn))}"
}

output "lambda_version" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.version,aws_lambda_function.from_s3.*.version))}"
}

output "lambda_source_code_hash" {
  value = "${join(",",concat(aws_lambda_function.from_local.*.source_code_hash,aws_lambda_function.from_s3.*.source_code_hash))}"
}
