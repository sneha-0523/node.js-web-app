# 🚀 End-to-End CI/CD Pipeline with AWS, Terraform, Docker & GitHub Actions

---

## 📌 Project Overview

This project demonstrates a **production-style DevOps pipeline** where infrastructure provisioning and application deployment are fully automated using modern cloud-native tools.

The system integrates Infrastructure as Code (IaC), containerization, and CI/CD automation to deliver a scalable and maintainable deployment workflow.

---

### 🔹 Key Capabilities

* Infrastructure provisioning using **Terraform**
* CI/CD automation using **GitHub Actions**
* Containerization using **Docker**
* Image storage using **AWS ECR**
* Deployment on **AWS EC2**
* Real-time notifications using **Slack**
* Migration from Jenkins → GitHub Actions based on real-world constraints

---

## 🏗️ Architecture

<img width="700" height="400" alt="image" src="https://github.com/user-attachments/assets/379af4b2-d840-4def-aee3-d6818d6d7e55" />


### 🔹 High-Level Flow

```text
Developer → GitHub → GitHub Actions → Docker Build → AWS ECR → EC2 Deployment → Live Application
                              ↓
                        Terraform (Infrastructure Provisioning)
```

---

## 🧠 Architecture Decisions

### 🔹 Why GitHub Actions over Jenkins?

* Jenkins required dedicated infrastructure and higher memory
* t3.micro instance caused performance issues
* GitHub Actions provides:

  * Managed CI/CD
  * Better scalability
  * Lower operational overhead

👉 **Decision:** Migrated to GitHub Actions for efficiency and reliability

---

### 🔹 Why Docker?

* Ensures consistent runtime environment
* Simplifies deployment across environments
* Enables faster rollbacks and updates

---

### 🔹 Why Terraform?

* Infrastructure as Code (IaC)
* Reproducible and version-controlled infrastructure
* Eliminates manual configuration drift

---

### 🔹 Why AWS ECR?

* Secure and private container registry
* Seamless integration with AWS IAM
* Optimized for EC2 deployments

---

## 📁 Project Structure

<img width="1702" height="435" alt="image" src="https://github.com/user-attachments/assets/97e81f33-1035-4101-a28c-13c7f4db92dd" />


## 📁 Project Structure (Modular & Scalable Design)

```text
node.js-web-app/
│
├── server/                          # Application source code (Node.js app)
│
├── Terraform/                       # Infrastructure as Code (IaC)
│   │
│   ├── application-server/          # EC2 module for application deployment
│   │   ├── main.tf
│   │   ├── user_data.sh             # Bootstraps Docker + runs app container
│   │   ├── variables.tf
│   │   └── output.tf
│   │
│   ├── jenkins-server/              # Jenkins EC2 module (deprecated later)
│   │   ├── main.tf
│   │   ├── user_data.sh
│   │   ├── variables.tf
│   │   └── output.tf
│   │
│   ├── networking.tf                # VPC, Subnets, Route Tables, IGW
│   ├── iam.tf                       # IAM roles and policy attachments
│   ├── ec2.tf                       # EC2 instance definitions
│   ├── ecr.tf                       # AWS ECR repository setup
│   ├── s3.tf                        # S3 bucket (state / artifacts)
│   ├── key-pairs.tf                 # SSH key generation & storage
│   ├── providers.tf                 # AWS provider configuration
│   ├── variables.tf                 # Input variables
│   ├── outputs.tf                   # Output values
│   ├── secrets.tf                   # Secrets handling (if used)
│   ├── random.tf                    # Random resource generation
│   ├── terraform.tfvars             # Variable values
│   └── terraform.tfstate*           # Local state files (gitignored)
│
├── Dockerfile                       # Defines container image for app
├── Dockerfile.test                  # (Optional) Testing container
├── Jenkinsfile                      # Legacy CI pipeline (replaced later)
├── package.json
├── package-lock.json
│
├── .github/
│   └── workflows/
│       └── deploy.yml               # GitHub Actions CI/CD pipeline
│
└── README.md                        # Project documentation
```


## ⚙️ Infrastructure (Terraform)

<img width="1797" height="762" alt="image" src="https://github.com/user-attachments/assets/191e4e6d-ad44-4da9-a3ee-0e28997d9799" />

<img width="1831" height="425" alt="image" src="https://github.com/user-attachments/assets/b48b6ff0-da58-4fc8-a13d-a03c642208fc" />


### 🔹 Components Provisioned

* VPC (10.0.0.0/16)
* Public Subnet
* Internet Gateway
* Route Tables
* Security Groups
* EC2 Instances (App + Jenkins - deprecated)
* IAM Roles & Policies
* AWS ECR Repository
* S3 Bucket (optional backend)

---

## 🔐 Security Considerations

* IAM roles used instead of hardcoded credentials
* Secrets managed via GitHub Secrets
* Restricted Security Group rules
* SSH access controlled

👉 **Future Improvement:** Replace SSH with AWS SSM Session Manager

---

## 🔄 CI/CD Pipeline

<img width="1792" height="661" alt="image" src="https://github.com/user-attachments/assets/f5792fa1-df84-4759-baad-6081a8c3d21d" />


### 🔹 Pipeline Workflow

1. Code pushed to GitHub
2. GitHub Actions triggered
3. Docker image built
4. Image pushed to AWS ECR
5. EC2 pulls latest image
6. Application deployed via Docker

---

## 🐳 Docker Workflow

<img width="1920" height="461" alt="image" src="https://github.com/user-attachments/assets/744bfa51-c3f0-4972-bdcf-d1d93b97a918" />


```bash
docker build -t nodejs-web-app .
docker tag nodejs-web-app:latest <ECR_URL>
docker push <ECR_URL>
```

---

## ☁️ Deployment on EC2

<img width="1838" height="745" alt="image" src="https://github.com/user-attachments/assets/681b9afe-e32a-4930-ad16-dbf87cbf20d2" />


```bash
docker stop my-app || true
docker rm my-app || true

docker pull <ECR_URL>

docker run -d -p 8000:8000 --name my-app <ECR_URL>
```

---

## 🔔 Slack Integration

* Build Success Alerts
* Build Failure Alerts
* Deployment Notifications

---

## 🔑 GitHub Secrets Used

| Secret Name           | Description     |
| --------------------- | --------------- |
| AWS_ACCESS_KEY_ID     | AWS Access Key  |
| AWS_SECRET_ACCESS_KEY | AWS Secret Key  |
| AWS_ACCOUNT_ID        | AWS Account ID  |
| EC2_HOST              | EC2 Public IP   |
| EC2_USER              | EC2 Username    |
| EC2_SSH_KEY           | Private SSH Key |

---

## 🚨 Engineering Challenges & Debugging Insights

---

### ❌ Terraform State Drift

* **Issue:** Inconsistent infrastructure updates
* **Cause:** Local state mismatch / manual AWS changes
* **Solution:** Strict IaC workflow, no manual edits

---

### ❌ Resource Dependency Issues

* **Issue:** EC2 failed during provisioning
* **Cause:** Improper resource dependency order
* **Fix:**

```hcl
depends_on = [aws_iam_role_policy_attachment.example]
```

---

### ❌ User Data Script Failure

* **Issue:** App not deployed after EC2 launch
* **Debug:**

```bash
cat /var/log/cloud-init-output.log
```

---

### ❌ Jenkins Failure (Critical Decision Point)

* **Issue:** Jenkins crashed on t3.micro
* **Cause:** Memory limitations
* **Solution:** Migrated to GitHub Actions

👉 **Key Learning:** Tool selection must align with infrastructure constraints

---

### ❌ ECR Authentication Failure

* **Issue:** Docker push failed in CI
* **Fix:**

```bash
aws ecr get-login-password | docker login
```

---

### ❌ Network Accessibility Issue

* **Issue:** App not accessible externally
* **Cause:** Port not open in Security Group
* **Fix:** Allowed port 8000

---

### ❌ Docker Inconsistency

* **Issue:** Different behavior across builds
* **Fix:** Locked dependencies + clean builds

---

## 🚀 Future Enhancements

* Application Load Balancer (ALB)
* Auto Scaling Group
* HTTPS (SSL via ACM)
* CloudWatch Monitoring
* DevSecOps tools (Trivy, Snyk)
* Terraform Remote Backend (S3 + DynamoDB)

---

## 🎯 Key Skills Demonstrated

* Infrastructure as Code (Terraform)
* CI/CD Pipeline Design
* Debugging & Problem Solving
* Cloud Networking (AWS)
* Containerization (Docker)
* System Design Thinking

---

## 👩‍💻 Author

Sneha Varshney
DevSecOps Enthusiast | AI Aspirant

---
