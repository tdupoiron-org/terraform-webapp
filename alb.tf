resource "aws_lb" "app_lb" {
  name               = "${var.owner}-app-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = [for subnet in aws_subnet.app_subnets : subnet.id]

  tags = {
    Owner = var.owner
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.owner}-app-tg-tf"
  port     = "${var.webapp_port}"
  protocol = "HTTP"
  vpc_id   = aws_vpc.app_vpc.id
  target_type = "ip"

  health_check {
    path = "/status"
  }

  tags = {
    Owner = var.owner
  }
}

resource "aws_lb_listener" "app_lb_listeners" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app_tg.arn
    type             = "forward"
  }

  tags = {
    Owner = var.owner
  }
}