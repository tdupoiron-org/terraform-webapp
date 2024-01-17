resource "aws_vpc" "bbs_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name  = "${var.owner}-bbs-vpc-tf"
    Owner = var.owner
  }
}

resource "aws_subnet" "bbs_subnets" {
  count             = length(var.aws_availability_zones)
  vpc_id            = aws_vpc.bbs_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = var.aws_availability_zones[count.index]

  tags = {
    Name  = "${var.owner}-bbs-subnet-tf-${var.aws_availability_zones[count.index]}"
    Owner = var.owner
  }
}