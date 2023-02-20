resource "aws_s3_bucket" "terraformstatefile" {
  bucket = "terraforms3devops"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "DevopsAutomateCloud"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_versioning" "versioning_S3" {
  bucket = aws_s3_bucket.terraformstatefile.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_S3" {
  bucket = aws_s3_bucket.terraformstatefile.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
 
  attribute {
    name = "LockID"
    type = "S"
  }
}