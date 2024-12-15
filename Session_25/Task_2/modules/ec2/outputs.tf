output "web_public_ips" {
  description = "Public IP addresses assigned to the instances."
  value       = aws_instance.web[*].public_ip
}

output "deployer_key_name" {
  description = "The key pair name."
  value       = aws_key_pair.deployer.key_name
}
