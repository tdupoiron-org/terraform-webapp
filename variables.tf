variable "owner" {
  description = "The owner of the resources"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_availability_zones" {
  description = "The AWS availability zones to deploy resources in"
  type        = list(string)
}

variable "ovh_region" {
  description = "The OVH region to deploy resources in"
  type        = string
}

variable "ovh_domain" {
  description = "The OVH domain to deploy resources in"
  type        = string
}

variable "bbs_subdomain" {
  description = "The subdomain to deploy resources in"
  type        = string
}