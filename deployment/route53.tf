resource "aws_route53_zone" "zone" {
  name = local.dns_name
}

resource "aws_route53_record" "dns" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = local.dns_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}
