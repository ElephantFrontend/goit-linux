resource "aws_rds_cluster_parameter_group" "aurora" {
  count = var.create_aurora ? 1 : 0

  name   = "${var.identifier_prefix}-aurora-cluster-params"
  family = "aurora-postgresql${split(".", var.aurora_engine_version)[0]}"

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

resource "aws_rds_cluster" "aurora" {
  count = var.create_aurora ? 1 : 0

  cluster_identifier      = "${var.identifier_prefix}-aurora"
  engine                  = "aurora-postgresql"
  engine_version          = var.aurora_engine_version
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora[0].name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count = var.create_aurora ? var.aurora_instance_count : 0

  identifier         = "${var.identifier_prefix}-aurora-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora[0].id
  instance_class     = var.aurora_instance_class
  engine             = aws_rds_cluster.aurora[0].engine
  engine_version     = aws_rds_cluster.aurora[0].engine_version
}

