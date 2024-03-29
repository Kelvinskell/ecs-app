# Provider Configurations
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.20.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}

# Create A VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecs-vpc"
  cidr = "10.20.0.0/22"

  azs             = var.azs
  private_subnets = ["10.20.0.0/25", "10.20.0.128/25", "10.20.1.0/25"]
  public_subnets  = ["10.20.1.128/25", "10.20.2.0/25", "10.20.2.128/25"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Environment = local.env
    Purpose     = local.purpose
  }
}

# Create security groups
module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

# Create Elastic Filesystem
module "elastic_filesystem" {
  source = "./modules/efs"

  efs_sg               = module.security_groups.EFS-sg_id
  vpc_private_subnet1  = module.vpc.private_subnets[0]
  vpc_private_subnet2  = module.vpc.private_subnets[1]
  vpc_private_subnets3 = module.vpc.private_subnets[2]
}

module "application_load_balancer" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  alb_sg         = module.security_groups.Alb-sg_id
  public_subnets = flatten([module.vpc.public_subnets[*]])
}

module "ecs" {
  source = "./modules/ecs"

  efs_id             = module.elastic_filesystem.efs_id
  azs = var.azs
  tg_arn = module.application_load_balancer.tg_arn
  private_subnets = flatten([module.vpc.private_subnets[*]])
  ecs_sg = module.security_groups.ECS-sg_id
}