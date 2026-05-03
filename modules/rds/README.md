# modules/rds

Reusable Terraform module for AWS databases.

## Modes

- `use_aurora = true`: creates `aws_rds_cluster` + one writer `aws_rds_cluster_instance`
- `use_aurora = false`: creates one `aws_db_instance`

## Shared resources (both modes)

- `aws_db_subnet_group`
- `aws_security_group`
- parameter group resources for selected DB mode

