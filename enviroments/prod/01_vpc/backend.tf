terraform {
  backend "s3" {
    key = "prod/vpc/terraform.tfstate"
  }  
}