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

resource "aws_internet_gateway" "bbs_igw" {
  vpc_id = aws_vpc.bbs_vpc.id

  tags = {
    Name  = "${var.owner}-bbs-igw"
    Owner = var.owner
  }
}

resource "aws_route_table" "bbs_rtb" {
  vpc_id = aws_vpc.bbs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bbs_igw.id
  }

  tags = {
    Name  = "${var.owner}-bbs-rtb-tf"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "bbs_route_table_associations" {
  count          = length(var.aws_availability_zones)
  subnet_id      = aws_subnet.bbs_subnets[count.index].id
  route_table_id = aws_route_table.bbs_rtb.id
}