resource "aws_instance" "default" {
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  key_name      = var.key-pair

  iam_instance_profile = var.iam_instance_profile

  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_groups
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
  }

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = var.name
  }
}
