resource "aws_db_parameter_group" "postgres" {
  count = var.create_rds_instance ? 1 : 0

  name   = "${var.identifier_prefix}-postgres-params"
  family = "postgres${split(".", var.rds_engine_version)[0]}"

  parameter {
    name         = "max_connections"
    value        = var.db_max_connections
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_statement"
    value        = var.db_log_statement
    apply_method = "immediate"
  }

  parameter {
    name         = "work_mem"
    value        = var.db_work_mem
    apply_method = "immediate"
  }
}

resource "aws_db_instance" "postgres" {
  count = var.create_rds_instance ? 1 : 0

  identifier             = "${var.identifier_prefix}-postgres"
  engine                 = "postgres"
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.postgres[0].name
  vpc_security_group_ids = [aws_security_group.db.id]
}

