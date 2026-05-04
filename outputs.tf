output "vpc_id" {
  description = "Created VPC ID"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "rds_endpoint" {
  description = "RDS or Aurora endpoint"
  value       = module.rds.primary_endpoint
}

output "jenkins_service" {
  description = "Jenkins Kubernetes service"
  value       = module.jenkins.jenkins_service_name
}

output "argocd_service" {
  description = "Argo CD Kubernetes service"
  value       = module.argo_cd.argocd_server_service_name
}

output "grafana_service" {
  description = "Grafana Kubernetes service"
  value       = module.argo_cd.grafana_service_name
}

output "backend_bucket" {
  description = "S3 backend bucket name, if created via Terraform"
  value       = var.create_backend_resources ? module.s3_backend[0].s3_bucket_name : null
}

output "backend_lock_table" {
  description = "DynamoDB lock table name, if created via Terraform"
  value       = var.create_backend_resources ? module.s3_backend[0].dynamodb_table_name : null
}

