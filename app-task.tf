resource "aws_ecs_task_definition" "ecs_app_task_definition" {
  family                = "${var.owner}-${var.webapp_name}-task"
  container_definitions = templatefile("${path.module}/${var.webapp_name}-task.json", { owner = var.owner, appname = var.webapp_name, appimage = var.webapp_image, appport = var.webapp_port})

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