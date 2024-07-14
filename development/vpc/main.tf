/*******************************
* VPC
*******************************/
resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "dev-vpc"
  }
}

/*******************************
* Internet Gateway
*******************************/
resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-internet-gateway"
  }
}

/*******************************
* Subnet - public
*******************************/
resource "aws_subnet" "dev_web_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.web_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "dev-web-subnet"
  }
}

/*******************************
* Root Table - public
*******************************/
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_internet_gateway.id
  }

  tags = {
    Name = "terraform-dev-public-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev_web_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
}


output "dev_vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "dev_vpc_subnet_id" {
  value = aws_subnet.dev_web_subnet.id
}