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

variable "webapp_subdomain" {
  type = string
}

variable "webapp_name" {
  type = string
}

variable "webapp_image" {
  type = string
}

variable "webapp_port" {
  type = number
}