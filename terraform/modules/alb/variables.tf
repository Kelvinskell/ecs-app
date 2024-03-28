variable "alb_sg" {
  type = string
}

variable "public_subnets" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}