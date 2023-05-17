module "redirect_technative_nl" {
  source = "wearetechnative/terraform-aws-module-url-redirect/aws"

  domain               = "technative.nl"
  route53_zone_name    = "technative.nl."
  redirect_target_url  = "https://technative.eu"

  providers = {
    aws.us-east-1: aws.us-east-1
  }

}
