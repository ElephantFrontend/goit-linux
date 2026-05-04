# GoIT Linux: AWS + Terraform + EKS Platform

This repository contains a modular Terraform setup for:
- VPC
- EKS
- RDS (single instance and optional Aurora)
- ECR
- Jenkins (Helm)
- Argo CD (Helm)
- Prometheus + Grafana (kube-prometheus-stack via Helm)

## Project structure

Matches the requested structure with modules in `modules/`, app Helm chart in `charts/django-app/`, and Django skeleton in `Django/`.

## Prerequisites

- Terraform >= 1.6
- AWS CLI configured (`aws configure`)
- kubectl
- helm

## Quick start

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and backend.tf
terraform init
terraform plan
terraform apply
```

## Post-deploy checks

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```

```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
kubectl port-forward svc/argocd-server 8081:443 -n argocd
kubectl port-forward svc/grafana 3000:80 -n monitoring
```

Open:
- Jenkins: http://localhost:8080
- Argo CD: https://localhost:8081
- Grafana: http://localhost:3000

## Important backend note

Because Terraform backend is initialized before resources are created, bootstrap state resources first:
1. Temporarily comment backend block in `backend.tf` and set `create_backend_resources=true`.
2. `terraform init && terraform apply`.
3. Re-enable backend block values and run `terraform init -reconfigure`.

