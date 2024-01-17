resource "ovh_domain_zone_record" "bbs_lb_cert_validation_record" {
  zone      = var.ovh_domain
  subdomain = tolist(aws_acm_certificate.bbs_lb_cert.domain_validation_options)[0].resource_record_name
  fieldtype = tolist(aws_acm_certificate.bbs_lb_cert.domain_validation_options)[0].resource_record_type
  target    = tolist(aws_acm_certificate.bbs_lb_cert.domain_validation_options)[0].resource_record_value
  ttl       = 3600
}

resource "ovh_domain_zone_record" "bbs_domain_record" {
  zone      = var.ovh_domain
  subdomain = var.bbs_subdomain
  fieldtype = "CNAME"
  target    = "${aws_lb.bbs_lb.dns_name}."
}