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


data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my-dev-vpc.id]
  }
}

data "aws_lb" "my-alb" {
  name = "my-alb"
}


data "aws_lb_target_group" "test" {
  arn  = var.lb_tg_arn
  name = var.lb_tg_name
}