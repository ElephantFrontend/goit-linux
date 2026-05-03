locals {
  engine_major = try(split(".", var.engine_version)[0], var.engine_version)

  default_parameter_group_family = (
    var.engine == "postgres" ? "postgres${local.engine_major}" :
    var.engine == "aurora-postgresql" ? "aurora-postgresql${local.engine_major}" :
    var.engine == "mysql" ? "mysql${local.engine_major}" :
    var.engine == "aurora-mysql" ? "aurora-mysql${local.engine_major}" :
    null
  )

  parameter_group_family = coalesce(var.parameter_group_family, local.default_parameter_group_family)

  db_sg_name = "${var.name}-db-sg"
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name}-subnet-group"
  })
}

resource "aws_security_group" "this" {
  name        = local.db_sg_name
  description = "Security group for ${var.name} database"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = local.db_sg_name
  })
}

resource "aws_vpc_security_group_ingress_rule" "cidr" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  from_port         = var.port
  to_port           = var.port
  ip_protocol       = "tcp"
  description       = "DB access from CIDR ${each.value}"
}

resource "aws_vpc_security_group_ingress_rule" "sg" {
  for_each = toset(var.allowed_security_group_ids)

  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.value
  from_port                    = var.port
  to_port                      = var.port
  ip_protocol                  = "tcp"
  description                  = "DB access from security group ${each.value}"
}

resource "aws_db_parameter_group" "rds" {
  count = var.use_aurora ? 0 : 1

  name   = "${var.name}-rds-pg"
  family = local.parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name}-rds-pg"
  })
}

resource "aws_db_parameter_group" "aurora_instance" {
  count = var.use_aurora ? 1 : 0

  name   = "${var.name}-aurora-instance-pg"
  family = local.parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name}-aurora-instance-pg"
  })
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster" {
  count = var.use_aurora ? 1 : 0

  name   = "${var.name}-aurora-cluster-pg"
  family = local.parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name}-aurora-cluster-pg"
  })
}

