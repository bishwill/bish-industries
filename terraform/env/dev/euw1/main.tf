terraform {
  required_version = ">= 0.13"

  backend "s3" {
    
    bucket = "bishop-industries-terraform-state"
    key = "bish-industries.tfstate"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
  
}

provider "aws" {
    region = local.aws_region
}
