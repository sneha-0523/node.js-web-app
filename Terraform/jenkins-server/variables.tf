variable "key-pair" {
  type = string
}

variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "iam_instance_profile" {
  type = string
}

# 🔽 ADD THESE (IMPORTANT)

variable "repository-url" {
  type = string
}

variable "repository-test-url" {
  type = string
}

variable "repository-staging-url" {
  type = string
}

variable "instance-id" {
  type = string
}

variable "public-dns" {
  type = string
}

variable "admin-username" {
  type = string
}

variable "admin-password" {
  type = string
}

variable "admin-email" {
  type = string
}

variable "admin-fullname" {
  type = string
}

variable "bucket-logs-name" {
  type = string
}

variable "bucket-config-name" {
  type = string
}

variable "remote-repo" {
  type = string
}

variable "job-name" {
  type = string
}

variable "job-id" {
  type = string
}
