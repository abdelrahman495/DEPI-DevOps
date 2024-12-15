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

variable "web_user_data" {
  description = "User data to provide when launching the instance."
  type        = string
  default     = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo apt install -y apache2
  wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
  tar xvfz node_exporter-*.*-amd64.tar.gz
  cd node_exporter-*.*-amd64
  ./node_exporter
  EOF
}

variable "web_user_data_replace_on_change" {
  description = "When used in combination with user_data will trigger a destroy and recreate of the EC2 instance when set to true."
  type        = bool
  default     = true
}

variable "web_tags" {
  description = "Maps of tags to assign to the resources."
  type        = list(map(string))
  default = [{
    Name        = "My Web Server 1"
    Service     = "Apache2"
    Environment = "Development"
    Role        = "Web Server"
    Team        = "DevOps"
    }, {
    Name        = "My Web Server 2"
    Service     = "Apache2"
    Environment = "Development"
    Role        = "Web Server"
    Team        = "DevOps"
  }]
}

variable "ingress_security_groups" {
  type = set(string)
}
