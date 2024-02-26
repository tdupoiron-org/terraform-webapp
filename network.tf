resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name  = "${var.owner}-${var.webapp_name}-vpc-tf"
    Owner = var.owner
  }
}

resource "aws_subnet" "app_subnets" {
  count             = length(var.aws_availability_zones)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = var.aws_availability_zones[count.index]

  tags = {
    Name  = "${var.owner}-${var.webapp_name}-subnet-tf-${var.aws_availability_zones[count.index]}"
    Owner = var.owner
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name  = "${var.owner}-${var.webapp_name}-igw"
    Owner = var.owner
  }
}

resource "aws_route_table" "app_rtb" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name  = "${var.owner}-${var.webapp_name}-rtb-tf"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "app_route_table_associations" {
  count          = length(var.aws_availability_zones)
  subnet_id      = aws_subnet.app_subnets[count.index].id
  route_table_id = aws_route_table.app_rtb.id
}