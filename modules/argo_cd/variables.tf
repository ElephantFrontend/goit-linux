variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "EKS cluster CA certificate (base64)"
  type        = string
}

variable "namespace" {
  description = "Namespace for Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "7.8.2"
}

variable "service_type" {
  description = "Argo CD server service type"
  type        = string
  default     = "LoadBalancer"
}

variable "app_name" {
  description = "Argo CD Application name"
  type        = string
  default     = "django-app"
}

variable "app_namespace" {
  description = "Namespace where app should be deployed"
  type        = string
  default     = "default"
}

variable "app_repo_url" {
  description = "Git repo URL with Helm chart for the app"
  type        = string
}

variable "app_repo_path" {
  description = "Path to Helm chart in app repo"
  type        = string
  default     = "charts/django-app"
}

variable "app_target_revision" {
  description = "Git branch/tag Argo CD should track"
  type        = string
  default     = "main"
}

variable "repo_name" {
  description = "Repository alias inside Argo CD"
  type        = string
  default     = "django-repo"
}

variable "repo_username" {
  description = "Username for Git repo auth (if needed)"
  type        = string
  default     = ""
}

variable "repo_password" {
  description = "Password/token for Git repo auth (if needed)"
  type        = string
  default     = ""
  sensitive   = true
}

