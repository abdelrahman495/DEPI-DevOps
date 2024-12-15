resource "aws_instance" "web" {
  count = 2

  ami           = var.web_ami
  instance_type = var.web_instance_type

  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = var.web_tags[count.index]
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "web_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 9100
    to_port         = 9100
    protocol        = "tcp"
    security_groups = var.ingress_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Web SG"
  }
}

resource "null_resource" "ansible_playbook" {
  triggers = {
    web_instance_ids = join(",", aws_instance.web[*].id)
  }
  provisioner "local-exec" {
    command = "cd ansible && ansible-playbook playbook.yaml"
  }
}
