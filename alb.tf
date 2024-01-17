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

resource "aws_lb_target_group" "bbs_tg" {
  name     = "${var.owner}-bbs-tg-tf"
  port     = 7990
  protocol = "HTTP"
  vpc_id   = aws_vpc.bbs_vpc.id
  target_type = "ip"

  health_check {
    path = "/status"
  }

  tags = {
    Owner = var.owner
  }
}

resource "aws_lb_listener" "bbs_lb_listeners" {
  load_balancer_arn = aws_lb.bbs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.bbs_tg.arn
    type             = "forward"
  }

  tags = {
    Owner = var.owner
  }
}