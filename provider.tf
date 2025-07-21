terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "octa-byte"
    key          = "state/terraform.tfstate"
    region       = "ap-south-1" # Ensure this matches your AWS region
    use_lockfile = true         # Optional: for state locking
    encrypt      = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

