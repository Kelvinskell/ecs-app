output "efs_id" {
  description = "The id of the elastic filesystem"
  value       = aws_efs_file_system.efs.id
}