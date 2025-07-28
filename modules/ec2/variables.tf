variable "public_subnet_id" {
  description = "The ID of the public subnet where the EC2 instance will be launched"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
}
