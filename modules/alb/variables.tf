variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}
variable "target_instance_id" {
  description = "Target instance ID"
}
variable "security_group_id" {}
