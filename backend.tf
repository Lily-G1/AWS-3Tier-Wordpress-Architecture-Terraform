# Store state file in S3 bucket
terraform {
  backend "s3" {
    bucket                  = "wordpress-3tier-state-files"
    region                  = "us-east-1"
    key                     = "wordpress-3tier/terraform.tfstate"
    shared_credentials_file = "~/.aws/credentials2"
  }
}
