# Create Elastic Filesystem to be used by ECS tasks as volume
resource "aws_efs_file_system" "efs" {
  creation_token = "ecs-app"
  encrypted      = true

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name        = "ecs-app-efs",
    Environment = "prod"
  }
}

# Create EFS mount target for az1
resource "aws_efs_mount_target" "mount1" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.vpc_private_subnet1
  security_groups = [var.efs_sg]
}

# Create EFS mount target for az2
resource "aws_efs_mount_target" "mount2" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.vpc_private_subnet2
  security_groups = [var.efs_sg]
}

# Create EFS mount target for az3
resource "aws_efs_mount_target" "mount3" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.vpc_private_subnets3
  security_groups = [var.efs_sg]
}