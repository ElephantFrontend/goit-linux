resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier_prefix}-db-subnets"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.identifier_prefix}-db-subnets"
  }
}

resource "aws_security_group" "db" {
  name        = "${var.identifier_prefix}-db-sg"
  description = "Database security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks
    content {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

