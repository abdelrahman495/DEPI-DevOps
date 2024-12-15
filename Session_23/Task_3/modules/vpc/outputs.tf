output "public_subnet_id" {
  description = "The IDs of the subnets."
  value       = aws_subnet.public_subnet[*].id
}

output "public_subnet_cidr" {
  description = "The IPv4 CIDR blocks for the subnets."
  value       = aws_subnet.public_subnet[*].cidr_block
}

output "private_subnet_id" {
  description = "The IDs of the subnets."
  value       = aws_subnet.private_subnet[*].id
}

output "public_sg_id" {
  description = "ID of the security group."
  value       = aws_security_group.public_sg.id
}

output "private_sg_id" {
  description = "ID of the security group."
  value       = aws_security_group.private_sg.id
}
