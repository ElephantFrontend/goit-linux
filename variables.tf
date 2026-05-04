variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "goit-linux"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "How many AZs to use"
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "node_group_desired_size" {
  description = "EKS node group desired size"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "EKS node group min size"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "EKS node group max size"
  type        = number
  default     = 3
}

variable "node_instance_types" {
  description = "EKS node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database admin username"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "create_rds_instance" {
  description = "Create standalone RDS instance"
  type        = bool
  default     = true
}

variable "create_aurora" {
  description = "Create Aurora cluster"
  type        = bool
  default     = false
}

variable "jenkins_chart_version" {
  description = "Jenkins Helm chart version"
  type        = string
  default     = "5.8.52"
}

variable "argocd_chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "7.8.2"
}

variable "monitoring_chart_version" {
  description = "kube-prometheus-stack chart version"
  type        = string
  default     = "61.7.2"
}

variable "create_backend_resources" {
  description = "Create S3 and DynamoDB for Terraform backend"
  type        = bool
  default     = false
}

variable "backend_bucket_name" {
  description = "Existing or to-be-created backend bucket name"
  type        = string
  default     = ""
}

variable "backend_dynamodb_table_name" {
  description = "Existing or to-be-created backend table name"
  type        = string
  default     = ""
}

