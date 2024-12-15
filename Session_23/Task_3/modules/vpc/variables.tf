variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main VPC"
  }
}

variable "public_subnet_cidrs" {
  description = "The IPv4 CIDR blocks for the subnets."
  type        = set(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_azs" {
  description = "AZs for the subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_tags" {
  description = "Maps of tags to assign to the resources."
  type        = set(map(string))
  default = [{
    "Name" = "Public Subnet 1"
    }, {
    "Name" = "Public Subnet 2"
    }, {
    "Name" = "Public Subnet 3"
  }]
}

variable "private_subnet_cidrs" {
  description = "The IPv4 CIDR blocks for the subnets."
  type        = set(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "private_subnet_azs" {
  description = "AZs for the subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnet_tags" {
  description = "Maps of tags to assign to the resources."
  type        = set(map(string))
  default = [{
    "Name" = "Private Subnet 1"
    }, {
    "Name" = "Private Subnet 2"
    }, {
    "Name" = "Private Subnet 3"
  }]
}

variable "internet_gw_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main Internet Gateway"
  }
}

variable "public_rt_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main Public Route Table"
  }
}

variable "nat_gw_allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the NAT Gateway."
  type        = string
}

variable "nat_gw_subnet_id" {
  description = "The Subnet ID of the subnet in which to place the NAT Gateway."
  type        = string
}

variable "nat_gw_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main NAT Gateway"
  }
}

variable "private_rt_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main Private Route Table"
  }
}

variable "private_sg_ingress_cidr" {
  description = "List of CIDR blocks."
  type        = set(string)
}
