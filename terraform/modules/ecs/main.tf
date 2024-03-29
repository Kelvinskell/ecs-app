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

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "news-app"
    container_port   = 5000
  }

  network_configuration {
    subnets = var.public_subnets
    security_groups = [var.ecs_sg]
    #assign_public_ip = true
  }
}