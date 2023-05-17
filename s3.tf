resource "random_pet" "this" {
  length = 1
}

module "website_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket                  = "${var.domain}-${random_pet.this.id}"
  force_destroy           = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true

  object_ownership = "BucketOwnerEnforced"
  control_object_ownership = true

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules = [{
      redirect = {
        host_name          = module.route53_http_redirect_target_url.hostname
        http_redirect_code = 301
        protocol           = module.route53_http_redirect_target_url.protocol
        replace_key_with   = module.route53_http_redirect_target_url.path_and_param
      }
    }]
  }

}

module "route53_http_redirect_target_url" {
  source  = "TechNative-B-V/url-parser/null"
  version = "0.1.1"

  url    = var.redirect_target_url
}
