# Terraform AWS URL Redirect ![](https://img.shields.io/github/actions/workflow/status/wearetechnative/terraform-aws-module-url-redirect/tflint.yaml)

<!-- SHIELDS -->

This module implements a HTTP and HTTPS redirect from a domain to a target URL.
Configuration is as simple as possible.

It creates a SSL certificate, Route53, Cloudfront and S3 resources.

[![](we-are-technative.png)](https://technative.eu)

## Usage

Below an example how to use this module ...

```hcl
module "redirect_technative_nl" {
  source = "wearetechnative/terraform-aws-module-url-redirect/aws"

  route53_zone_name   = "technative.nl."
  domain              = "technative.nl"
  redirect_target_url = "https://technative.eu"

  providers = {
    aws.us-east-1: aws.us-east-1
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0, < 5.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=2.3.0, < 3.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | terraform-aws-modules/acm/aws | 4.3.1 |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | 3.1.0 |
| <a name="module_route53_http_redirect_target_url"></a> [route53\_http\_redirect\_target\_url](#module\_route53\_http\_redirect\_target\_url) | TechNative-B-V/url-parser/null | 0.1.1 |
| <a name="module_website_bucket"></a> [website\_bucket](#module\_website\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.website-domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The primary domain name to use for the website | `string` | n/a | yes |
| <a name="input_redirect_target_url"></a> [redirect\_target\_url](#input\_redirect\_target\_url) | Redirect target - should be a full URL. If http:// or https:// is excluded, the scheme of the request will be used | `string` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | The name of the hosted zone in Route53 where the SSL certificates will be created | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
