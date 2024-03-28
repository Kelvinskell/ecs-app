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

# Define local values
locals {
  environment = "Prod"
  purpose     = "ECS App" 
}

# Create A VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecs-vpc"
  cidr = "10.20.0.0/22"

  azs             = var.azs
  private_subnets = ["10.20.0.0/25", "10.20.0.128/25", "10.20.1.0/25"]
  public_subnets  = ["10.20.1.128/25", "10.20.2.0/25", "10.20.2.128/25"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Environment = local.environment
    Purpose = local.purpose
  }
}