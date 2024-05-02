resource "aws_s3_bucket" "s3-state" {
  bucket = "nti-backend-state-file"

  tags = {
    Name        = "s3-bucket-state"
    Environment = "Dev"
  }

  lifecycle {
    prevent_destroy = true
  }
}

terraform {
  backend "s3" {
    bucket = "nti-backend-state-file"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-table"
  }
}



resource "aws_dynamodb_table" "terraform-table" {
  name           = "state-db"
  billing_mode   = "PAY_PER_REQUEST"  
  hash_key       = "LockID"  # key for lock if any person try to apply when some when apply
  attribute {
    name = "LockID"
    type = "S"  
  }
}

