resource "aws_iam_user" "deployer" {
  name = "${local.dns_name}-deployer"
  path = "/service/static-sites/"

  tags = {
    "Name" = local.dns_name
  }
}

resource "aws_iam_access_key" "deployer" {
  user = aws_iam_user.deployer.name
}

resource "aws_iam_user_policy" "deployer" {
  name   = "${local.dns_name}-deployer"
  user   = aws_iam_user.deployer.name
  policy = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    sid    = "AllowDiscoverBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [aws_s3_bucket.s3.arn]
  }

  statement {
    sid    = "AllowWriteToBucket"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.s3.arn}/*"]
  }

  statement {
    sid    = "AllowCreateInvalidations"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]

    # Cloudfront does not support resource level permissioning
    # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html
    resources = ["*"]
  }
}

