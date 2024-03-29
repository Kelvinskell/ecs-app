# Create ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-app-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Create ECS Service
resource "aws_ecs_service" "ecs-svc" {
  name            = "ecs-app-svc"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.id
  desired_count = 2
  launch_type = "FARGATE"
  #iam_role = aws_iam_role.ecs_svc_execution_role.arn
  #depends_on = [ aws_iam_role.ecs_svc_execution_role ]

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "news-app"
    container_port   = 5000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b, us-east-1c ]"
  }

  network_configuration {
    subnets = var.private_subnets
    security_groups = [var.ecs_sg]
    #assign_public_ip = true
  }
}