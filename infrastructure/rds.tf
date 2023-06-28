# ---------------------------------------------------------------------------------------------------------------------
# RDS DB SUBNET GROUP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "garden-of-intelligence-db-sgrp"
  description = "Database Subnet Group"
  subnet_ids  = aws_subnet.private.*.id
}

# ---------------------------------------------------------------------------------------------------------------------
# RDS (POSTGRESQL)
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_db_instance" "db" {
  identifier = "garden-of-intelligence"

  engine         = "postgres"
  engine_version = "13.7"

  instance_class = "db.t3.micro"

  storage_type      = "gp2"
  allocated_storage = 20

  username = "root"
  password = "05cd8d797da4fb88a199c14294b5966fe9276e7c61c5476116addcf44facab4aa77a12541050c25312f3fd20f839cea4b2cdb1b42bfade1dd612027f6a1d4a01"

  multi_az = false
  vpc_security_group_ids  = [aws_security_group.db-sg.id]
  db_subnet_group_name    = aws_db_subnet_group.db-subnet-grp.id
}