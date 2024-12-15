module "aws_ec2" {
  source = "./modules/ec2"

  # Web Server Configuration
  key_name                = "Ansible Key"
  public_key              = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINw0c5Ss6VEzEqZSw52TMim7g6ATBn6+JsME8UQbnZqq Ansible Key"
  ingress_security_groups = [module.prometheus.prometheus_sg_id]
}

module "prometheus" {
  source = "./modules/prometheus"

  # Prometheus Server Configuration
  deployer_key_name = module.aws_ec2.deployer_key_name
}
