resource "aws_kms_key" "state_backend_bucket_kms_key" {
  description             = "Encrypt the state bucket objects"
  deletion_window_in_days = 10
}

# create state-files S3 bukets per each Env
resource "aws_s3_bucket" "state_backend_bucket" {
  bucket = "tf-state-bucket-${var.project_name}"

  lifecycle {
    prevent_destroy = true
  }
}

# enable S3 bucket versioning per each Env's bucket
resource "aws_s3_bucket_versioning" "state_backend_bucket_versioning" {
  bucket = aws_s3_bucket.state_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# enable S3 bucket encryption per each Env's bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "state_backend_bucket_encryption" {
  bucket = aws_s3_bucket.state_backend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.state_backend_bucket_kms_key.arn
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# block S3 bucket public access per each Env's bucket
resource "aws_s3_bucket_public_access_block" "state_backend_bucket_acl" {
  bucket = aws_s3_bucket.state_backend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# create DynamoDB table per each Env
resource "aws_dynamodb_table" "state_dynamo_table" {
  name = "tf-state-lock-${var.project_name}"

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"  
    type = "S"
  }
}