resource "aws_instance" "web" {
  ami           = var.web_ami
  instance_type = var.web_instance_type

  key_name  = aws_key_pair.deployer.key_name
  subnet_id = var.web_subnet_id
  # user_data                   = var.web_user_data
  # user_data_replace_on_change = var.web_user_data_replace_on_change
  vpc_security_group_ids = var.web_vpc_security_group_ids

  tags = var.web_tags

  depends_on = [aws_instance.db]
}

resource "aws_instance" "db" {
  ami           = var.db_ami
  instance_type = var.db_instance_type

  key_name  = aws_key_pair.deployer.key_name
  subnet_id = var.db_subnet_id
  # user_data              = var.db_user_data
  # user_data_replace_on_change = var.db_user_data_replace_on_change
  vpc_security_group_ids = var.db_vpc_security_group_ids

  tags = var.db_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_eip" "lb" {
  domain = "vpc"
}
