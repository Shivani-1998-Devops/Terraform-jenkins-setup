# Note: Configure this backend with your own S3 bucket
# Uncomment and update the bucket name to match your AWS account
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket-file-sssss"
    region = "us-east-1"
    key    = "jenkins-server/terraform.tfstate"
  }
}
