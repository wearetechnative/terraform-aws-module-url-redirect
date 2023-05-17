variable "domain" {
  description = "The primary domain name to use for the website"
  type        = string
}

variable "route53_zone_name" {
  description = "The name of the hosted zone in Route53 where the SSL certificates will be created"
  type        = string
}

variable "redirect_target_url" {
  description = "Redirect target - should be a full URL. If http:// or https:// is excluded, the scheme of the request will be used"
  type        = string
}

