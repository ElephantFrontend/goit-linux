resource "aws_db_instance" "this" {
  count = var.use_aurora ? 0 : 1

  identifier             = "${var.name}-instance"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.database_name
  username               = var.username
  password               = var.password
  port                   = var.port
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  apply_immediately      = var.apply_immediately
  deletion_protection    = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot    = var.skip_final_snapshot

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  parameter_group_name   = aws_db_parameter_group.rds[0].name

  tags = merge(var.tags, {
    Name = "${var.name}-instance"
  })
}

