provider "aws" {
  region              = local.region
  allowed_account_ids = [local.aws_account_id]
  access_key          = var.aws_access_key_id
  secret_key          = var.aws_secret_access_key
  # access_key          = var.aws_access_key
  # secret_key          = var.aws_secret_key
}

terraform {
  required_providers {
    aws = "~> 3.74"
  }
}
