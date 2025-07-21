variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "db_username" {
  type        = string
  description = "The username for the database"
}
variable "db_password" {
  type        = string
  description = "The password for the database"
}
variable "security_group_id" {
  type        = string
  description = "The security group id for the database"
}
