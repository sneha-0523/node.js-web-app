# 🔐 Generate private key for Web App
resource "tls_private_key" "web_app" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔐 Create AWS key pair (Web App)
resource "aws_key_pair" "nodejs-web-app-key" {
  key_name   = "nodejs-web-app"
  public_key = tls_private_key.web_app.public_key_openssh
}

# 💾 Save private key locally
resource "local_file" "web_app_pem" {
  content  = tls_private_key.web_app.private_key_pem
  filename = "nodejs-web-app.pem"
}


# 🔐 Generate private key for Jenkins
resource "tls_private_key" "jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔐 Create AWS key pair (Jenkins)
resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins"
  public_key = tls_private_key.jenkins.public_key_openssh
}

# 💾 Save private key locally
resource "local_file" "jenkins_pem" {
  content  = tls_private_key.jenkins.private_key_pem
  filename = "jenkins.pem"
}
