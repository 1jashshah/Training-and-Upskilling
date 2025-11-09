variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "demo-eks-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones (list of 2 zones recommended)"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets (count must match azs)"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets (count must match azs)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "node_instance_type" {
  description = "EC2 instance type for managed node group"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "RDS master password (change before apply!)"
  type        = string
  default     = "ChangeMe123!"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS (GB)"
  type        = number
  default     = 20
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "you"
  }
}

