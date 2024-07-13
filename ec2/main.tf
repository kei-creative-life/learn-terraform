# 2.EC2を起動
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

# 使用するproviderを定義するブロックq
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "app_server" {
  # MEMO: RegionによりAMI IDが異なる
  ami           = var.ami_id
  instance_type = var.instance_type
  # MEMO: us-west-2のRegionでは以下VPCの構築必要
  vpc_security_group_ids = []
  subnet_id              = var.subnet_id

  tags = {
    Name = "ExampleAppServerInstance"
  }
}