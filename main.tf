terraform {
  # Terraformがリソースを作成や更新削除などするためのAPIみたいなもの
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  # Terraformのver.を指定
  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./vpc"
}

# module "ec2" {
#   source = "./ec2"
# }
