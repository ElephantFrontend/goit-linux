output "s3_state_bucket_url" {
  description = "S3 URL for Terraform state bucket"
  value       = module.s3_backend.s3_bucket_url
}

output "dynamodb_lock_table_name" {
  description = "DynamoDB table name used for Terraform state locking"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by EKS"
  value       = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_ebs_csi_driver_status" {
  description = "EBS CSI addon status"
  value       = module.eks.ebs_csi_driver_status
}

output "kubectl_update_kubeconfig_command" {
  description = "Command to configure kubectl context"
  value       = "aws eks update-kubeconfig --region us-west-2 --name ${module.eks.cluster_name}"
}

output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = module.jenkins.namespace
}

output "jenkins_service_name" {
  description = "Jenkins service DNS inside cluster"
  value       = module.jenkins.service_name
}

output "argocd_namespace" {
  description = "Argo CD namespace"
  value       = module.argo_cd.namespace
}

output "argocd_server_service" {
  description = "Argo CD server service DNS inside cluster"
  value       = module.argo_cd.server_service
}

output "argocd_initial_admin_password_command" {
  description = "Command to read initial Argo CD admin password"
  value       = module.argo_cd.initial_admin_password_command
}

