terraform {
  backend "s3" {
    bucket         = "kennycloud-terraform-backend"   # Your S3 bucket
    key            = "production/terraform.tfstate"   # State file path
    region         = "us-east-1"                      # Bucket region
    dynamodb_table = "kennedy-terraform-lock"         # Lock table
    encrypt        = true
  }
}
