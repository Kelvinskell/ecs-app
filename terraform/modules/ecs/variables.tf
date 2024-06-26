variable "efs_id" {
  description = "Id of the elastic file system"
  type        = string
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "tg_arn" {
  type = string
}

variable "private_subnets" {
  type = list
}

variable "ecs_sg" {
  type = string
}