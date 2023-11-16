terraform {
  backend "s3" {
    bucket = "tf-state-bucket-terraformforawsecscluster"
    key    = "global/terraform.tfstate"
    region = "ap-northeast-1"
  }
}