# print out load balancer dns name
output "name" {
  description = "The public DNS name of the load balancer"
  value = module.application_load_balancer.alb_dns
}