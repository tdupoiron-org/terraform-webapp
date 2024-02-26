output "ecs_task_arn" {
  value = aws_ecs_task_definition.ecs_app_task_definition.arn
}

output "ecs_task_id" {
  value = aws_ecs_task_definition.ecs_app_task_definition.id
}

output "ecs_container_name" {
  value = "${var.owner}-${var.webapp_name}-task"
}