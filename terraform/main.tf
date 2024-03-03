terraform {

  required_version = "1.7.4"

  backend "s3" {
    bucket = "cardapiogo-terraform-state"
    key    = "states/terraform.tfstate"
    region = "sa-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "oprimogus"
      managed-by = "terraform"
    }
  }
}