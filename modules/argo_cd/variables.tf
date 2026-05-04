variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Base64 CA certificate from EKS"
  type        = string
}

variable "argocd_namespace" {
  description = "Argo CD namespace"
  type        = string
  default     = "argocd"
}

variable "monitoring_namespace" {
  description = "Monitoring namespace"
  type        = string
  default     = "monitoring"
}

variable "argocd_chart_version" {
  description = "Argo CD chart version"
  type        = string
}

variable "monitoring_chart_version" {
  description = "kube-prometheus-stack chart version"
  type        = string
}

