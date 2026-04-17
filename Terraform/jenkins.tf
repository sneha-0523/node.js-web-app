module "jenkins" {
  source ="./jenkins-server"

  key-pair = aws_key_pair.jenkins-key.key_name
  name     = "jenkins"

  subnet_id = aws_subnet.subnet-public-jenkins.id
  security_groups = [
    aws_security_group.allow-jenkins-traffic.id,
    aws_security_group.allow-ssh-traffic.id,
    aws_security_group.allow-all-outbound.id 
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins.name

  # 🔽 ALL THIS MUST BE INSIDE

  repository-url         = aws_ecr_repository.nodejs-web-app.repository_url
  repository-test-url    = aws_ecr_repository.nodejs-web-app-test.repository_url
  repository-staging-url = aws_ecr_repository.nodejs-web-app-staging.repository_url

  instance-id = module.application-server.instance-id

  public-dns = "dynamic"

  admin-username = var.admin-username
  admin-password = var.admin-password
  admin-fullname = var.admin-fullname
  admin-email    = var.admin-email

  bucket-logs-name   = aws_s3_bucket.nodejs-web-app-logs.id
  bucket-config-name = aws_s3_bucket.jenkins-config.id

  remote-repo = var.remote-repo
  job-name    = var.job-name

  job-id = random_id.job-id.hex
}
