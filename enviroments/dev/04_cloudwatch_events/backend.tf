terraform {
  backend "s3" {
    key = "dev/vpc/terraform.tfstate"
  }  
}