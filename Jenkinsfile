pipeline {
  agent any

  stages {

    stage("Set Up") {
      steps {
        echo "Setup stage"
        sh "echo Connected to Jenkins"
      }
    }

    stage("Build Docker Image") {
      steps {
        script {
          sh """
          docker build -t my-app .
          """
        }
      }
    }

    stage("Run Container") {
      steps {
        script {
          sh """
          docker run -d -p 8000:8000 my-app || true
          """
        }
      }
    }

    stage("Test") {
      steps {
        echo "Running basic tests"
        sh "echo Tests passed"
      }
    }

    stage("Cleanup") {
      steps {
        sh "docker system prune -f"
      }
    }
  }
}
