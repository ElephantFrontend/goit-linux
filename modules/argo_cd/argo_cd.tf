resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true
  timeout          = 900

  values = [
    templatefile("${path.module}/values.yaml", {
      service_type = var.service_type
    })
  ]
}

resource "helm_release" "argo_cd_apps" {
  name             = "argo-cd-apps"
  chart            = "${path.module}/charts"
  namespace        = var.namespace
  create_namespace = false

  values = [
    yamlencode({
      applications = [
        {
          name           = var.app_name
          namespace      = var.namespace
          project        = "default"
          repoURL        = var.app_repo_url
          targetRevision = var.app_target_revision
          path           = var.app_repo_path
          destination = {
            namespace = var.app_namespace
            server    = "https://kubernetes.default.svc"
          }
          syncPolicy = {
            automated = {
              prune    = true
              selfHeal = true
            }
          }
        }
      ]
      repositories = [
        {
          name     = var.repo_name
          url      = var.app_repo_url
          type     = "git"
          username = var.repo_username
          password = var.repo_password
        }
      ]
    })
  ]

  depends_on = [helm_release.argo_cd]
}

