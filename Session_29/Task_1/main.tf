module "aws_ec2" {
  source = "./modules/ec2"

  # Web Server Configuration
  key_name                = "Ansible Key"
  public_key              = file("/home/abdelrahman/.ssh/Ansible.pub")
  ingress_security_groups = [module.prometheus.prometheus_sg_id]
}

module "prometheus" {
  source = "./modules/prometheus"

  # Prometheus Server Configuration
  deployer_key_name = module.aws_ec2.deployer_key_name
}

module "jenkins_agent" {
  source = "./modules/jenkins_agent"

  # Jenkins Agent Server Configuration
  instance_type     = "t2.small"
  deployer_key_name = module.aws_ec2.deployer_key_name
}
