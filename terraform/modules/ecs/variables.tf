variable "efs_id" {
  description = "Id of the elastic file system"
  type        = string
}

variable "azs" {
  default = ["usest-1a", "us-east-1b", "us-east-1c"]
}

variable "tg_arn" {
  type = string
}

variable "public_subnets" {
  type = list
}

variable "ecs_sg" {
  type = string
}