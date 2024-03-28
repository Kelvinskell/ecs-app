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
  desired_count   = 3
  iam_role        = aws_iam_role.ecs_svc_role.arn
  depends_on      = [aws_iam_role_policy.ecs_svc_policy]

  load_balancer {
    target_group_arn = var.alb_arn
    container_name   = "news_app"
    container_port   = 5000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b, us-east-1c]"
  }
}