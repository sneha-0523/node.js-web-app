#! /bin/bash
echo "Hello Application Server" >> /home/ec2-user/application_rc.txt
#! /bin/bash

sudo yum update -y

# Install Docker
sudo yum install -y docker

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Login to ECR
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS --password-stdin ${repository_url}

# Pull image
docker pull ${repository_url}:latest

# Run container
docker run -d -p 80:8000 ${repository_url}:latest
