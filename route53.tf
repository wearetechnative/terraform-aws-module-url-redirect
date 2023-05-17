data "aws_route53_zone" "this" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "website-domain" {
  name    = var.domain
  type    = "A"
  zone_id = data.aws_route53_zone.this.zone_id

  alias {
    name    = module.cloudfront.cloudfront_distribution_domain_name
    zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
