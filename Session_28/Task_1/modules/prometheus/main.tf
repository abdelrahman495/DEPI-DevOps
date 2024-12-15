resource "aws_instance" "prometheus" {
  ami           = var.ami
  instance_type = var.instance_type

  iam_instance_profile        = aws_iam_instance_profile.prometheus_profile.name
  key_name                    = var.deployer_key_name
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change
  vpc_security_group_ids      = [aws_security_group.prometheus_sg.id]

  tags = var.tags
}

resource "aws_security_group" "prometheus_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
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
    "Name" = "Prometheus SG"
  }
}

resource "aws_iam_role" "prometheus_role" {
  name = "prometheus_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "prometheus_policy" {
  name = "prometheus_policy"
  role = aws_iam_role.prometheus_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "prometheus_profile" {
  name = "prometheus_profile"
  role = aws_iam_role.prometheus_role.name
}
