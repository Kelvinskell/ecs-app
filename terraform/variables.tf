variable "region" {
  default = "us-east-1"
  type = string
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type = list
}