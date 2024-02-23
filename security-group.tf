# This file creates a security group that allows all inbound and outbound traffic.
resource "aws_security_group" "app_sg" {
  name   = "${var.owner}-app-sg-tf"
  vpc_id = aws_vpc.app_vpc.id

  ingress {
    from_port   = "${var.webapp_port}"
    to_port     = "${var.webapp_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = var.owner
    Name  = "${var.owner}-app-sg-tf"
  }
}