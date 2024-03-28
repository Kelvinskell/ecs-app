# Create security groups

# Define locals
locals {
  env = "Prod"
}

# ALB security group
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress{
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = local.env
  }
}

# ECS Service Security group  
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow Flask inbound traffic"
  vpc_id      = var.vpc_id

  ingress{
    description     = "HTTP"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [ aws_security_group.alb_sg ]

  tags = {
    Environment = local.env
  }
}

# EFS Security group  
resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow NFS inbound traffic"
  vpc_id      = var.vpc_id

  ingress{
    description     = "HTTP"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [ aws_security_group.ecs_sg ]

  tags = {
    Environment = local.env
  }
}