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

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my-dev-vpc.id]
  }
}


# data "aws_subnets" "private_subnet"{
#   filter {
#     name = "private_subnets"
#     values = ["10.0.1.0/24"]
#    }
# }

# data "aws_subnets" "public_subnet"{
#   filter {
#     name = "public_subnets"
#     values = ["10.0.101.0/24"]
#    }
# }

