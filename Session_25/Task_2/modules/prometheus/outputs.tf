output "prometheus_public_ip" {
  description = "Public IP address assigned to the instance."
  value       = aws_instance.prometheus.public_ip
}

output "prometheus_sg_id" {
  description = "ID of the security group."
  value       = aws_security_group.prometheus_sg.id
}
