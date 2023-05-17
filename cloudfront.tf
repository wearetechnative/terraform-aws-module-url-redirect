module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.1"

  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  zone_id                   = data.aws_route53_zone.this.id

  providers = {
    aws = aws.us-east-1
  }
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.1.0"

  aliases = [var.domain]

  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  create_origin_access_identity = true
  origin_access_identities = {
    website = "Access website content"
  }

  origin = {
    s3 = {
      domain_name = module.website_bucket.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }

    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn = module.acm.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

