output "db_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.this.name
}

output "security_group_id" {
  description = "Security group ID for DB access"
  value       = aws_security_group.this.id
}

output "parameter_group_name" {
  description = "Active DB parameter group name"
  value = var.use_aurora
    ? aws_rds_cluster_parameter_group.aurora_cluster[0].name
    : aws_db_parameter_group.rds[0].name
}

output "endpoint" {
  description = "Primary endpoint of RDS/Aurora"
  value = var.use_aurora
    ? aws_rds_cluster.this[0].endpoint
    : aws_db_instance.this[0].address
}

output "reader_endpoint" {
  description = "Reader endpoint for Aurora (null for standard RDS)"
  value       = var.use_aurora ? aws_rds_cluster.this[0].reader_endpoint : null
}

output "port" {
  description = "Database port"
  value = var.use_aurora
    ? aws_rds_cluster.this[0].port
    : aws_db_instance.this[0].port
}

output "resource_id" {
  description = "RDS resource identifier"
  value = var.use_aurora
    ? aws_rds_cluster.this[0].cluster_resource_id
    : aws_db_instance.this[0].resource_id
}

output "arn" {
  description = "ARN of created database resource"
  value = var.use_aurora
    ? aws_rds_cluster.this[0].arn
    : aws_db_instance.this[0].arn
}

