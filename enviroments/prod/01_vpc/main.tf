module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-prod-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["ap-southeast-1a"]
  private_subnets = ["10.10.1.0/24"]
  public_subnets  = ["10.10.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}