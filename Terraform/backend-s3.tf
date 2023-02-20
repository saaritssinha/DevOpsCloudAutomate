terraform {
  backend "s3" {
    bucket = "terraforms3devops"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
  }
}