output "namespace" {
  description = "Jenkins namespace"
  value       = var.namespace
}

output "release_name" {
  description = "Jenkins Helm release name"
  value       = helm_release.jenkins.name
}

output "service_name" {
  description = "Jenkins service name"
  value       = "${helm_release.jenkins.name}.${var.namespace}.svc.cluster.local"
}

output "admin_user" {
  description = "Jenkins admin username"
  value       = var.admin_user
}

output "admin_password" {
  description = "Jenkins admin password"
  value       = var.admin_password
  sensitive   = true
}

