# S3 Bucket storing logs

resource "aws_s3_bucket" "nodejs-web-app-logs" {
  bucket = "sneha-nodejs-logs-2026-987654"
  acl = "private"
}

# S3 Bucket storing jenkins user data

resource "aws_s3_bucket" "jenkins-config" {
  bucket = "sneha-jenkins-config-2026-987654"
  acl = "private"
}

