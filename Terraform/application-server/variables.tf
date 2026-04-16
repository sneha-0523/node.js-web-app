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
