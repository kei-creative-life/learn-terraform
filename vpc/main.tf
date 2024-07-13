# VPCの作成
resource "aws_vpc" "terraform_dev_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "terraform-dev-vpc"
  }
}

# インターネットゲートウェイを作成
resource "aws_internet_gateway" "terraform_dev_internet_gateway" {
  vpc_id = aws_vpc.terraform_dev_vpc.id
	tags = {
    Name = "terraform-dev-internet-gateway"
  }
}

# サブネットの作成
resource "aws_subnet" "terraform_dev_web_subnet" {
	vpc_id = aws_vpc.terraform_dev_vpc.id
	cidr_block = var.web_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "terraform-dev-web-subnet"
  }
}