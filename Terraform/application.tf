module "application-server" {
  source = "./application-server"

  key-pair = aws_key_pair.nodejs-web-app-key.key_name
  name = "nodejs Web App"

  subnet_id = aws_subnet.subnet-public-web-app.id
  security_groups = [
    aws_security_group.allow-web-traffic.id,
    aws_security_group.allow-ssh-traffic.id,
    aws_security_group.allow-all-outbound.id
  ]

  iam_instance_profile = aws_iam_instance_profile.nodejs-web-app.name

  repository_url = aws_ecr_repository.nodejs-web-app.repository_url
}
