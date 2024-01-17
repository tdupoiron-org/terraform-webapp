resource "aws_ecs_cluster" "ecs_cluster_bbs" {
  name = "${var.owner}-ecs-cluster-bbs"

  tags = {
    Name  = "${var.owner}-ecs-cluster-bbs"
    Owner = "${var.owner}"
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

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "ecs_service_bbs" {
  name            = "${var.owner}-ecs-service-bbs"
  cluster         = aws_ecs_cluster.ecs_cluster_bbs.id
  task_definition = aws_ecs_task_definition.ecs_bbs_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [aws_subnet.bbs_subnets[0].id]
    assign_public_ip = true
    security_groups  = [aws_security_group.bbs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.bbs_tg.arn
    container_name   = "${var.owner}-${var.bbs_appname}-task"
    container_port   = 7990
  }

  tags = {
    Name  = "${var.owner}-ecs-service-bbs"
    Owner = "${var.owner}"
  }
}