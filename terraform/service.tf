resource "aws_ecs_task_definition" "app_node" {
  family                = "${local.tags.name}"
  execution_role_arn    = aws_iam_role.app_role_task_execution.arn
  task_role_arn         = aws_iam_role.app_role_task.arn
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = 1024
  memory                = 2048
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "${local.container_name}",
    "essential": true,
    "image": "358308582535.dkr.ecr.ap-south-1.amazonaws.com/node-app-backend:latest",
    "portMappings": [
      {
        "containerPort": 3000
      }
    ],
    "environment": ${jsonencode(local.env_vars)},
    "secrets": ${jsonencode(local.application_secrets)}
  }
]
 TASK_DEFINITION
}

resource "aws_ecs_service" "app" {
  name              = "${local.tags.name}"
  cluster           = local.ecs_cluster_id
  task_definition   = aws_ecs_task_definition.app_node.arn
  desired_count     = 2 
  launch_type       = "FARGATE"


  network_configuration {

  subnets           = local.private_subnet_ids
  security_groups   = [aws_security_group.app_ecs.id]

  }

  load_balancer {
    target_group_arn = local.target_group.arn
    container_name   = "${local.container_name}"
    container_port   = 3000
  }

}
