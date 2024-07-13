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