resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "octabyte-postgres"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "17.5"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true

  tags = {
    Name      = "PostgresDB"
    terraform = "true"
  }
}

output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
