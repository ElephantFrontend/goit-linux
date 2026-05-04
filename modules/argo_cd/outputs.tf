output "argocd_server_service_name" {
  description = "Argo CD server service name"
  value       = "argocd-server"
}

output "argocd_initial_admin_password_secret" {
  description = "Secret with Argo CD initial admin password"
  value       = "argocd-initial-admin-secret"
}

output "grafana_service_name" {
  description = "Grafana service name"
  value       = "grafana"
}

