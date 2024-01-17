resource "aws_cloudwatch_log_group" "bbs_log_group" {
  name              = "/ecs/${var.owner}-${var.bbs_appname}"
  retention_in_days = 30

  tags = {
    Owner = var.owner
  }
}