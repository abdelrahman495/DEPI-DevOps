module "aws_ec2" {
  source = "./modules/ec2"

  # Web Server Configuration
  web_subnet_id              = module.aws_vpc.public_subnet_id[0]
  web_vpc_security_group_ids = [module.aws_vpc.public_sg_id]

  # DB Server Configuration
  db_subnet_id              = module.aws_vpc.private_subnet_id[0]
  db_vpc_security_group_ids = [module.aws_vpc.private_sg_id]
}

module "aws_vpc" {
  source = "./modules/vpc"

  # NAT Gateway configuration
  nat_gw_allocation_id = module.aws_ec2.lb_id
  nat_gw_subnet_id     = module.aws_vpc.public_subnet_id[0]

  # Private Security Group Ingress CIDR configuration
  private_sg_ingress_cidr = [module.aws_vpc.public_subnet_cidr[0]]
}
