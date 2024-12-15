module "aws_ec2" {
  source = "./modules/ec2"

  # Web Server Configuration
  ingress_security_groups = [module.prometheus.prometheus_sg_id]
}

module "prometheus" {
  source = "./modules/prometheus"

  # Prometheus Server Configuration
  deployer_key_name = module.aws_ec2.deployer_key_name
}
