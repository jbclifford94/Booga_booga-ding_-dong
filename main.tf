terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = var.AWS_access_key_id
  secret_key = var.AWS_access_key_secret
  region     = "us-east-2"
}
