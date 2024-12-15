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

variable "user_data" {
  description = "User data to provide when launching the instance."
  type        = string
  default     = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo apt install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker ubuntu
  cd /home/ubuntu/
  git clone https://github.com/abdelrahman495/learn-prometheus.git
  docker volume create prometheus-data
  docker run -d \
    -p 9090:9090 \
    -v ./learn-prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v prometheus-data:/prometheus prom/prometheus
  EOF
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data will trigger a destroy and recreate of the EC2 instance when set to true."
  type        = bool
  default     = true
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
