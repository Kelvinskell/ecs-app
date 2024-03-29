output "alb_arn" {
  description = "The id of the load balancer"
  value       = aws_lb.alb.arn
}

output "alb_dns" {
  description = "The public DNS address of the load balancer"
  value = aws_lb.alb.dns_name
}