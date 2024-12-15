variable "key_name" {
  description = "The name for the key pair."
  type        = string
  default     = "deployer-key"
}

variable "public_key" {
  description = "The public key material."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHSKFmgcDPc//LBStkRoWf7k4jAf1opex5iaWUx0qoYQ abdelrahman07111999@gmail.com"
}

variable "web_ami" {
  description = "AMI to use for the instance."
  type        = string
  default     = "ami-0866a3c8686eaeeba" # us-east-1
}

variable "web_instance_type" {
  description = "Instance type to use for the instance."
  type        = string
  default     = "t2.micro"
}

variable "web_subnet_id" {
  description = "VPC Subnet ID to launch in."
  type        = string
}

# variable "web_user_data" {
#   description = "User data to provide when launching the instance."
#   type        = string
#   default     = <<-EOF
#   #!/bin/bash
#   sudo apt update
#   sudo apt install -y apache2
#   EOF
# }

# variable "web_user_data_replace_on_change" {
#   description = "When used in combination with user_data will trigger a destroy and recreate of the EC2 instance when set to true."
#   type        = bool
#   default     = true
# }

variable "web_vpc_security_group_ids" {
  description = "List of security group IDs to associate with."
  type        = set(string)
}

variable "web_tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "My Web Server"
    Service     = "Apache2"
    Environment = "Development"
    Role        = "Web Server"
    Team        = "DevOps"
  }
}

variable "db_ami" {
  description = "AMI to use for the instance."
  type        = string
  default     = "ami-0866a3c8686eaeeba" # us-east-1
}

variable "db_instance_type" {
  description = "Instance type to use for the instance."
  type        = string
  default     = "t2.micro"
}

variable "db_subnet_id" {
  description = "VPC Subnet ID to launch in."
  type        = string
}

# variable "db_user_data" {
#   description = "User data to provide when launching the instance."
#   type        = string
#   default     = <<-EOF
#   #!/bin/bash
#   sudo apt update
#   sudo apt install -y mysql-server
#   EOF
# }

# variable "db_user_data_replace_on_change" {
#   description = "When used in combination with user_data will trigger a destroy and recreate of the EC2 instance when set to true."
#   type        = bool
#   default     = true
# }

variable "db_vpc_security_group_ids" {
  description = "List of security group IDs to associate with."
  type        = set(string)
}

variable "db_tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "My DB Server"
    Service     = "MYSQL"
    Environment = "Development"
    Role        = "DB Server"
    Team        = "DevOps"
  }
}
