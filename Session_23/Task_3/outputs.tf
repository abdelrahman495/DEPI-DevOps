output "web_ssh_command" {
  value = "ssh ubuntu@${module.aws_ec2.web_public_ip}"
}

output "web_public_dns" {
  value = module.aws_ec2.web_public_dns
}

output "db_private_ip" {
  value = module.aws_ec2.db_private_ip
}
