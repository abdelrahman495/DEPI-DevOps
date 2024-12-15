module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = "my-vpc"
  cidr = "10.1.0.0/16"
}
