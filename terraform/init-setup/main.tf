terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.7"
    }
  }
}

provider "aws" {
  region = local.region
}

# Configure terraform remote state with S3 bucket and locking with DynamoDB table

terraform {
  backend "s3" {
    bucket         = "devops-05-terraform-state-102"
    key            = "init-setup/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "devops-05-terraform-state"
  }
}
