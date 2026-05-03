variable "jenkins_admin_password" {
  description = "Admin password for Jenkins"
  type        = string
  sensitive   = true
}

variable "argocd_app_repo_url" {
  description = "Git repository URL with Helm chart tracked by Argo CD"
  type        = string
}

variable "argocd_app_repo_path" {
  description = "Path to Helm chart in app repository"
  type        = string
  default     = "charts/django-app"
}

variable "argocd_app_target_revision" {
  description = "Branch/tag Argo CD tracks"
  type        = string
  default     = "main"
}

variable "argocd_repo_username" {
  description = "Optional username for Argo CD repository access"
  type        = string
  default     = ""
}

variable "argocd_repo_password" {
  description = "Optional password/token for Argo CD repository access"
  type        = string
  default     = ""
  sensitive   = true
}

variable "rds_use_aurora" {
  description = "If true deploy Aurora, otherwise deploy standard RDS instance"
  type        = bool
  default     = true
}

variable "rds_engine" {
  description = "Database engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "rds_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.4"
}

variable "rds_instance_class" {
  description = "RDS/Aurora instance class"
  type        = string
  default     = "db.t4g.medium"
}

variable "rds_multi_az" {
  description = "Multi-AZ for standard RDS mode"
  type        = bool
  default     = false
}

variable "rds_database_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "rds_username" {
  description = "Master username"
  type        = string
  default     = "postgres"
}

variable "rds_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "rds_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the DB"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "rds_parameter_group_family" {
  description = "Optional parameter group family override"
  type        = string
  default     = null
}

