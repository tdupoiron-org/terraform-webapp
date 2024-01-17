resource "aws_acm_certificate" "bbs_lb_cert" {
  domain_name       = "${var.bbs_subdomain}.${var.ovh_domain}"
  validation_method = "DNS"

  tags = {
    Owner = var.owner
  }
}

resource "aws_acm_certificate_validation" "bbs_lb_cert_validation" {
  certificate_arn         = aws_acm_certificate.bbs_lb_cert.arn
  validation_record_fqdns = [ovh_domain_zone_record.bbs_lb_cert_validation_record.subdomain]
}