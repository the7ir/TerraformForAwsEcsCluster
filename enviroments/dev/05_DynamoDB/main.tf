module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "my-table" // need to change
  hash_key = "id"

  attributes = [
    {
      name = "id" // need to Change theo cái gì cần lưu trong Fargate
      type = "N"  // need to Change, tùy vào name phía trên mà thay đổi thanh S, N, B
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}