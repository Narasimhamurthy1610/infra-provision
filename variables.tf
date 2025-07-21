variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "default"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_username" {
  description = "The username for the RDS instance"
  default     = "octabyte_admin"
}

variable "db_password" {
  description = "The password for the RDS instance"
  default     = "octabyte2025"
  sensitive   = true
}

