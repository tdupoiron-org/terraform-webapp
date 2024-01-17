resource "aws_lb" "bbs_lb" {
  name               = "${var.owner}-bbs-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bbs_sg.id]
  subnets            = [for subnet in aws_subnet.bbs_subnets : subnet.id]

  tags = {
    Owner = var.owner
  }
}