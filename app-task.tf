resource "aws_ecs_task_definition" "ecs_app_task_definition" {
  family                = "${var.owner}-${var.webapp_name}-task"

  container_definitions = jsonencode(
    [
      {
        "name": "${var.owner}-${var.webapp_name}-task",
        "image": "${var.webapp_image}",
        "essential": true,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/${var.owner}-${var.webapp_name}",
            "awslogs-region": "eu-west-3",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "portMappings": [
          {
            "containerPort": "${var.webapp_port}",
            "hostPort": "${var.webapp_port}"
          }
        ],
        "healthCheck": {
          "command": [
            "CMD-SHELL",
            "curl -f http://localhost:${var.webapp_port}${var.webapp_heathcheck_path} || exit 1"
          ],
          "interval": 30,
          "timeout": 5,
          "retries": 3,
          "startPeriod": 60
        },
        "tags": [
          {
            "key": "Owner",
            "value": "${var.owner}-${var.webapp_name}"
          }
        ],
        "exec": {
          "config": {
            "user": "root",
            "enable_exec": true
          }
        }
      }
    ]
  )

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskRole.arn

  cpu    = 2048
  memory = 4096

  tags = {
    Name  = "${var.owner}-ecs-task"
    Owner = "${var.owner}"
  }
}