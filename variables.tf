variable "owner" {
  description = "The owner of the resources"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "ovh_region" {
  description = "The OVH region to deploy resources in"
  type        = string
}