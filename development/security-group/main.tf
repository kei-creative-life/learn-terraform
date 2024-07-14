variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

/******************************
 * SecurityGroup - public
 ******************************/
resource "aws_security_group" "dev_security_group" {
  name        = "dev-security-group"
  description = "security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "dev-security-group"
  }
}

output "dev_security_group_id" {
	value = aws_security_group.dev_security_group.id
}