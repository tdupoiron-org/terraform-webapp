resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.owner}-${var.webapp_name}"
  retention_in_days = 30

  tags = {
    Owner = var.owner
  }
}