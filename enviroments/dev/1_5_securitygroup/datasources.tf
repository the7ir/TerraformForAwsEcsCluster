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