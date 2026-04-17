pipeline {
agent any

environment {
AWS_REGION = "us-east-1"
ACCOUNT_ID = "869329820328"
REPO_NAME = "nodejs-web-app"
}

stages {

```
stage("Set Up") {
  steps {
    echo "Setup stage"
    sh "echo Connected to Jenkins"
  }
}

stage("Login to ECR") {
  steps {
    script {
      sh """
      aws ecr get-login-password --region ${AWS_REGION} | docker login \
      --username AWS \
      --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
      """
    }
  }
}

stage("Build Image") {
  steps {
    script {
      sh """
      docker build -t ${REPO_NAME} .
      docker tag ${REPO_NAME}:latest ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:latest
      """
    }
  }
}

stage("Push to ECR") {
  steps {
    script {
      sh """
      docker push ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:latest
      """
    }
  }
}

stage("Deploy Container") {
  steps {
    script {
      sh """
      docker stop my-app || true
      docker rm my-app || true

      docker run -d -p 8000:8000 --name my-app \
      ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:latest
      """
    }
  }
}

stage("Cleanup") {
  steps {
    sh "docker system prune -f"
  }
}
```

}
}
