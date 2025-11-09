variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "tags" {
  type = map(string)
}

