data "aws_vpc" "my-dev-vpc" {
  filter {
    name = "tag:Environment"
    values = ["dev"]
   }
  filter {
    name = "tag:Name"
    values = ["my-dev-vpc"]
   }
}

data "aws_security_group" "dev_private_sg" {
  filter {
    name   = "tag:Name"
    values = ["private-sg"]
  }
}