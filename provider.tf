terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["~/.aws/credentials2"]
}