variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

/*******************************
* EC2 - public web server
*******************************/
resource "aws_instance" "web_server" {
  # MEMO: RegionによりAMI IDが異なる
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  # MEMO: us-west-2のRegionでは以下VPCの構築必要
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "dev-web-server"
  }
}