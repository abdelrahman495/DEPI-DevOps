output "web_public_ip" {
  description = "Public IP address assigned to the instance."
  value       = aws_instance.web.public_ip
}

output "web_public_dns" {
  description = "Public DNS name assigned to the instance."
  value       = aws_instance.web.public_dns
}

output "db_private_ip" {
  description = "Public IP address assigned to the instance."
  value       = aws_instance.db.private_ip
}

output "lb_id" {
  description = "Contains the EIP allocation ID."
  value       = aws_eip.lb.id
}
