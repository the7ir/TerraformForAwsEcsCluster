module "public_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "public-example"
  repository_type = "public"

  repository_read_write_access_arns = ["arn:aws:iam::012345678901:role/terraform"] // need to change
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  public_repository_catalog_data = {
    description       = "Docker container for some things"
    about_text        = file("${path.module}/files/ABOUT.md")   // chưa xác định được file này lấy ở cùng thư mục hay ở đâu?
    usage_text        = file("${path.module}/files/USAGE.md")
    operating_systems = ["Linux"]
    architectures     = ["x86"]
    logo_image_blob   = filebase64("${path.module}/files/clowd.png")
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}