resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.vpc_tags
}

resource "aws_subnet" "public_subnet" {
  count = 3

  vpc_id     = aws_vpc.main.id
  cidr_block = tolist(var.public_subnet_cidrs)[count.index]

  availability_zone       = var.public_subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = tolist(var.public_subnet_tags)[count.index]
}

resource "aws_subnet" "private_subnet" {
  count = 3

  vpc_id     = aws_vpc.main.id
  cidr_block = tolist(var.private_subnet_cidrs)[count.index]

  availability_zone = var.private_subnet_azs[count.index]

  tags = tolist(var.private_subnet_tags)[count.index]
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

  tags = var.internet_gw_tags
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = var.public_rt_tags
}

resource "aws_route_table_association" "public_rt_association" {
  count = 3

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.nat_gw_allocation_id
  subnet_id     = var.nat_gw_subnet_id

  tags = var.nat_gw_tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = var.private_rt_tags
}

resource "aws_route_table_association" "private_rt_association" {
  count = 3

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow SSH and HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public SG"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.private_sg_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private SG"
  }
}
