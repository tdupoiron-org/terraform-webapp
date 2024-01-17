# This file creates a security group that allows all inbound and outbound traffic.
resource "aws_security_group" "bbs_sg" {
  name   = "${var.owner}-bbs-sg-tf"
  vpc_id = aws_vpc.bbs_vpc.id

  tags = {
    Owner = var.owner
    Name  = "${var.owner}-bbs-sg-tf"
  }
}