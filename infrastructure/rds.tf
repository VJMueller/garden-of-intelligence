# ---------------------------------------------------------------------------------------------------------------------
# RDS DB SUBNET GROUP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "${var.APP_NAME}-db-sgrp"
  description = "Database Subnet Group"
  subnet_ids  = aws_subnet.private.*.id
}

# ---------------------------------------------------------------------------------------------------------------------
# RDS (POSTGRESQL)
# ---------------------------------------------------------------------------------------------------------------------
resource "random_id" "postgres-garden-of-intelligence-password" {
  byte_length = 8
}

resource "aws_db_instance" "garden-of-intelligence" {
  identifier = var.APP_NAME
  db_name    = "garden_of_intelligence"

  engine         = "postgres"
  engine_version = "13.10"

  instance_class = "db.t3.micro"

  storage_type        = "gp2"
  allocated_storage   = 20
  skip_final_snapshot = true

  username = "root"
  password = random_id.postgres-garden-of-intelligence-password.hex

  # publicly_accessible                 = true
  iam_database_authentication_enabled = true

  multi_az               = false
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-grp.id
}
