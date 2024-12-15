variable "deployer_key_name" {
  description = "The name for the key pair."
  type        = string
}

variable "ami" {
  description = "AMI to use for the instance."
  type        = string
  default     = "ami-0866a3c8686eaeeba" # us-east-1
}

variable "instance_type" {
  description = "Instance type to use for the instance."
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "My Prometheus Server"
    Service     = "Prometheus"
    Environment = "Development"
    Role        = "Prometheus Server"
    Team        = "DevOps"
  }
}
