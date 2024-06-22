terraform {
  required_providers {
    awscc = {
      source  = "hashicorp/awscc"
      version = "1.3.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "awscc" {
}

provider "aws" {
}
