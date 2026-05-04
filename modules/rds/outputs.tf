output "rds_instance_endpoint" {
  description = "RDS endpoint"
  value       = try(aws_db_instance.postgres[0].address, null)
}

output "aurora_cluster_endpoint" {
  description = "Aurora cluster endpoint"
  value       = try(aws_rds_cluster.aurora[0].endpoint, null)
}

output "primary_endpoint" {
  description = "Primary endpoint chosen from RDS or Aurora"
  value       = coalesce(try(aws_db_instance.postgres[0].address, null), try(aws_rds_cluster.aurora[0].endpoint, null))
}

