# aws_instance.web:
resource "aws_instance" "web" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  tags = {
    Name        = "My Web Server"
    Service     = "Apache2"
    Environment = "Development"
    Role        = "Web Server"
    Team        = "DevOps"
  }
}
