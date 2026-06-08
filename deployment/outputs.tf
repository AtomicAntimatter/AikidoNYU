output "deployer_access_key_id" {
  value = aws_iam_access_key.deployer.id
}

output "deployer_secret_access_key" {
  value = nonsensitive(aws_iam_access_key.deployer.secret)
}

output "bucket_name" {
  value = aws_s3_bucket.s3.id
}

output "distribution_id" {
  value = aws_cloudfront_distribution.cf.id
}

