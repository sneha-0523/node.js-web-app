module "jenkins" {
  source ="./jenkins-server"

  key-pair = aws_key_pair.jenkins-key.key_name
  name = "jenkins"

  subnet_id = aws_subnet.subnet-public-jenkins.id
  security_groups = [
    aws_security_group.allow-jenkins-traffic.id,
    aws_security_group.allow-ssh-traffic.id
  ]
}
