module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  // Create Internet GateWay -> muốn gọi Id của Internet Gateway thì bước qua xác của VPC =))
  create_igw = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}