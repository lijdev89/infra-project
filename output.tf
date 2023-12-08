output "frontend-url-prod" {
  value = "http://${var.hostname}.${var.hosted_zone_name}"
}
