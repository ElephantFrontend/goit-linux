output "namespace" {
  description = "Argo CD namespace"
  value       = var.namespace
}

output "release_name" {
  description = "Argo CD Helm release name"
  value       = helm_release.argo_cd.name
}

output "server_service" {
  description = "Argo CD server service DNS"
  value       = "argocd-server.${var.namespace}.svc.cluster.local"
}

output "initial_admin_password_command" {
  description = "Command to read initial Argo CD admin password"
  value       = "kubectl -n ${var.namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

