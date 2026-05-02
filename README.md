# Project: Terraform + EKS + Jenkins + Argo CD

Проєкт піднімає повний CI/CD і GitOps ланцюжок у Kubernetes:
- S3 + DynamoDB для Terraform state
- VPC + ECR + EKS (з `aws-ebs-csi-driver` addon)
- Jenkins через Helm для CI
- Argo CD через Helm для GitOps
- Helm chart `charts/django-app` для Django застосунку

## Структура

- `main.tf`, `backend.tf`, `variables.tf`, `outputs.tf`
- `modules/s3-backend` - S3 bucket + DynamoDB lock table
- `modules/vpc` - VPC, subnets, IGW, NAT, routes
- `modules/ecr` - ECR repository
- `modules/eks` - EKS cluster, node group, EBS CSI addon
- `modules/jenkins` - Helm release Jenkins + JCasC Kubernetes cloud
- `modules/argo_cd` - Helm release Argo CD + chart для Application/Repository
- `charts/django-app` - Django Deployment/Service/ConfigMap/HPA
- `Jenkinsfile` - pipeline build/push/update-values

## 1) Підготовка змінних

```bash
cp terraform.tfvars.example terraform.tfvars
```

Заповніть у `terraform.tfvars`:
- `jenkins_admin_password`
- `argocd_app_repo_url`
- `argocd_repo_username`/`argocd_repo_password` (опційно)

## 2) Terraform apply

```bash
terraform init
terraform plan
terraform apply
```

## 3) Доступ до EKS

```bash
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks
kubectl get nodes
```

## 4) Jenkins credentials

Для `Jenkinsfile` додайте credentials у Jenkins:
- `aws-jenkins-creds` (AWS Credentials: Access key + Secret key)
- `aws-account-id` (String)
- `ecr-repository-name` (String)
- `git-token` (String, token для push у deployment repo)
- `target-repo-url` (String, HTTPS URL deployment repo)

Pipeline (`Jenkinsfile`) робить:
1. Checkout коду з Dockerfile
2. Build + push образу в ECR через Kaniko
3. Оновлення `tag` у `charts/django-app/values.yaml` іншого repo
4. Commit + push у `main`

## 5) Argo CD auto-sync

Argo CD Application створюється Terraform-модулем `modules/argo_cd` і:
- стежить за `argocd_app_repo_url`
- відслідковує `argocd_app_target_revision` (типово `main`)
- автоматично синхронізує зміни (`prune: true`, `selfHeal: true`)

Отримати початковий пароль Argo CD admin:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
echo
```

## 6) Видалення ресурсів

```bash
terraform destroy
```

