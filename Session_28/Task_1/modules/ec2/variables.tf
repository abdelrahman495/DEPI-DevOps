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
