resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true
  timeout          = 900

  values = [
    templatefile("${path.module}/values.yaml", {
      admin_user     = var.admin_user
      admin_password = var.admin_password
      service_type   = var.service_type
      namespace      = var.namespace
    })
  ]
}

