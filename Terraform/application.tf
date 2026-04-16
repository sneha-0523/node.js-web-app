module "application-server" {
  source = "./application-server"

  key-pair = aws_key_pair.nodejs-web-app-key.key_name
  name = "nodejs Web App"

  subnet_id = aws_subnet.subnet-public-web-app.id
  security_groups = [
    aws_security_group.allow-web-traffic.id,
    aws_security_group.allow-ssh-traffic.id
  ]
}
