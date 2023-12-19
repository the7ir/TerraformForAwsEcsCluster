terraform {
  backend "s3" {
    key = "dev/securitygroup/terraform.tfstate"
  }  
}