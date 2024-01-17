resource "aws_ecs_task_definition" "ecs_bbs_task_definition" {
  family                = "${var.owner}-${var.bbs_appname}-task"
  container_definitions = templatefile("${path.module}/${var.bbs_appname}-task.json", { owner = var.owner, appname = var.bbs_appname, appimage = var.bbs_appimage})

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  cpu                      = 2048
  memory                   = 4096

  tags = {
    Name  = "${var.owner}-ecs-task"
    Owner = "${var.owner}"
  }
}