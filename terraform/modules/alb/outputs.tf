output "alb_id" {
  description = "The id of the load balancer"
  value       = aws_lb.alb.id
}