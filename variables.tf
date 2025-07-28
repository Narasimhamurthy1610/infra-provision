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

variable "private_key_path" {
  description = "Path to the private key for SSH access to EC2 instances"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro"
}


variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

/*variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
*/

variable "node_groups" {
  description = "Map of node group configurations"
  type        = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}