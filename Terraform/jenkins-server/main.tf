resource "aws_instance" "default" {
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  key_name      = var.key-pair

  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_groups
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
  }

  tags = {
    Name = var.name
  }
}
