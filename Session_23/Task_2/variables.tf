#variable "availability_zones" {
#  type = map(string)
#  default = {
#    "0" = "us-east-1a"
#    "1" = "us-east-1b"
#    "2" = "us-east-1c"
#  }
#}

variable "availability_zones" {
  type    = set(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
