resource "aws_rds_cluster" "aurora" {
  count = var.create_aurora ? 1 : 0

  cluster_identifier      = "${var.identifier_prefix}-aurora"
  engine                  = "aurora-postgresql"
  engine_version          = var.aurora_engine_version
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
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

