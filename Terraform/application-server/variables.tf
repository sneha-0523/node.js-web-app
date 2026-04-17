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

variable "repository_url" {
  type = string
}
