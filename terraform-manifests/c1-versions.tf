# Terraform Block
terraform {
  required_version = "~> 1.2.4" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.1"
    }    
    random = {
      source = "hashicorp/random"
      version = "~> 3.3.2"
    }            
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
   profile = "221643363539_PowerUser_And_IAM"
  }      
}

# Provider Block
provider "aws" {
  region  = var.aws_region
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
