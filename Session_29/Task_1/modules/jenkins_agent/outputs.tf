output "jenkins_agent_public_ip" {
  description = "Public IP address assigned to the instance."
  value       = aws_instance.jenkins_agent.public_ip
}

output "jenkins_agent_sg_id" {
  description = "ID of the security group."
  value       = aws_security_group.jenkins_agent_sg.id
}
