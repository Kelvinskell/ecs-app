output "alb_arn" {
  description = "The id of the load balancer"
  value       = aws_lb.alb.arn
}