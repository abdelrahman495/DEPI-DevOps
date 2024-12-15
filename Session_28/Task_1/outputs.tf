output "web_public_ips" {
  value = module.aws_ec2.web_public_ips
}

output "prometheus_public_ip" {
  value = module.prometheus.prometheus_public_ip
}
