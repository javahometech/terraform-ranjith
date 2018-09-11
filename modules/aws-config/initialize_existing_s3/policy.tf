# Create policy that allows AWS Config service to put files into the S3 bucket
data "aws_iam_policy_document" "config_s3_put_files" {
  statement {
    sid       = "AllowAWSConfigPutFiles"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${data.template_file.config.vars.s3_bucket_name}/*"]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid       = "AllowAWSConfigBucketAccess"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${data.template_file.config.vars.s3_bucket_name}"]
  }
}
