resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  for_each = var.availability_zones

  vpc_id = aws_vpc.main.id
  #  cidr_block        = "10.0.${each.key}.0/24"
  cidr_block = "10.0.${index(tolist(var.availability_zones), each.key)}.0/24"
  #  availability_zone = each.value
  availability_zone = each.key

  tags = {
    #    Name = "Main-${each.key}"
    Name = "Main-${index(tolist(var.availability_zones), each.key)}"
  }
}
