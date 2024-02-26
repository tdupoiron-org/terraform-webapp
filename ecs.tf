resource "aws_ecs_cluster" "ecs_cluster_app" {
  name = "${var.owner}-ecs-cluster-${var.webapp_name}"

  tags = {
    Name  = "${var.owner}-ecs-cluster-${var.webapp_name}"
    Owner = "${var.owner}"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.owner}-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    Name  = "${var.owner}-ecs-taskExecutionRole"
    Owner = "${var.owner}"
  }
}

resource "aws_iam_role" "ecsTaskRole" {
  name               = "${var.owner}-ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  inline_policy {
    name = "ecsTaskRolePolicy"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "ssm:UpdateInstanceInformation",
              "ssmmessages:CreateControlChannel",
              "ssmmessages:CreateDataChannel",
              "ssmmessages:OpenControlChannel",
              "ssmmessages:OpenDataChannel"
            ],
            "Resource" : "*"
          }
        ]
      }
    )

  }

  tags = {
    Name  = "${var.owner}-ecs-ecsTaskRole"
    Owner = "${var.owner}"
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "ecs_service_app" {
  name                   = "${var.owner}-ecs-service-${var.webapp_name}"
  enable_execute_command = true
  cluster                = aws_ecs_cluster.ecs_cluster_app.id
  task_definition        = aws_ecs_task_definition.ecs_app_task_definition.arn
  launch_type            = "FARGATE"
  desired_count          = 1

  network_configuration {
    subnets          = [aws_subnet.app_subnets[0].id]
    assign_public_ip = true
    security_groups  = [aws_security_group.app_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "${var.owner}-${var.webapp_name}-task"
    container_port   = var.webapp_port
  }

  tags = {
    Name  = "${var.owner}-ecs-service-${var.webapp_name}"
    Owner = "${var.owner}"
  }
}