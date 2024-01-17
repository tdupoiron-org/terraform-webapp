variable "owner" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_availability_zones" {
  type = list(string)
}

variable "ovh_region" {
  type = string
}

variable "ovh_domain" {
  type = string
}

variable "bbs_subdomain" {
  type = string
}

variable "bbs_appname" {
  type = string
}

variable "bbs_appimage" {
  type = string
}