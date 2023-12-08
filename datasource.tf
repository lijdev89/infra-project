data "aws_route53_zone" "jehshopdns" {
  name = var.hosted_zone_name
}
