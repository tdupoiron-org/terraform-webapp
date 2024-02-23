resource "aws_acm_certificate" "app_lb_cert" {
  domain_name       = "${var.webapp_subdomain}.${var.ovh_domain}"
  validation_method = "DNS"

  tags = {
    Owner = var.owner
  }
}

resource "aws_acm_certificate_validation" "app_lb_cert_validation" {
  certificate_arn         = aws_acm_certificate.app_lb_cert.arn
  validation_record_fqdns = [ovh_domain_zone_record.app_lb_cert_validation_record.subdomain]
}