terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.70.0"
    }
  }

  backend "s3" {
    bucket = "Demo-terraform-state-bucket-forfun"
    key    = "state/terraform_state.tfstate"
    region = "ap-northeast-1"
  }
}