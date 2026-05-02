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

