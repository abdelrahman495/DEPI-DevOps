resource "aws_instance" "jenkins_agent" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name               = var.deployer_key_name
  vpc_security_group_ids = [aws_security_group.jenkins_agent_sg.id]

  tags = var.tags
}

resource "aws_security_group" "jenkins_agent_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Jenkins Agent SG"
  }
}

resource "null_resource" "ansible_playbook" {
  triggers = {
    jenkins_agent_instance_id = aws_instance.jenkins_agent.id
  }
  provisioner "local-exec" {
    command = "cd ansible && ansible-playbook jenkins_agent_playbook.yaml"
  }
}
