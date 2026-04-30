# lesson-7: Terraform + EKS + ECR + Helm

Проєкт створює:
- Terraform backend: S3 + DynamoDB lock
- VPC: 3 public + 3 private subnet
- ECR: репозиторій для Django image
- EKS: Kubernetes кластер у приватних subnet
- Helm chart: Deployment, Service (LoadBalancer), ConfigMap, HPA

## Структура

- `main.tf` - підключення модулів
- `backend.tf` - S3 backend для state
- `outputs.tf` - загальні outputs
- `modules/s3-backend` - S3 + DynamoDB
- `modules/vpc` - мережа
- `modules/ecr` - ECR
- `modules/eks` - EKS cluster + node group
- `charts/django-app` - Helm chart застосунку

## Bootstrap backend

Terraform не може одночасно використовувати і створювати той самий S3 backend.
1. Тимчасово закоментуйте блок `backend "s3"` у `backend.tf`.
2. Виконайте `terraform init && terraform apply` для створення S3/DynamoDB.
3. Поверніть `backend "s3"` і виконайте `terraform init -migrate-state`.

## Terraform

```bash
cd lesson-7
terraform init
terraform plan
terraform apply
```

## Налаштування kubectl для EKS

```bash
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks
kubectl get nodes
```

## Push Django image в ECR

```bash
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_REGION=us-west-2
ECR_REPO=lesson-7-django
IMAGE_TAG=latest

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
docker build -t "$ECR_REPO:$IMAGE_TAG" ../
docker tag "$ECR_REPO:$IMAGE_TAG" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG"
```

## Helm deploy

Перед деплоєм оновіть `charts/django-app/values.yaml`:
- `image.repository` -> ваш реальний ECR URL
- `config.*` -> актуальні змінні середовища

```bash
cd lesson-7
helm upgrade --install django-app ./charts/django-app
kubectl get svc
kubectl get hpa
```

## Видалення

```bash
cd lesson-7
helm uninstall django-app
terraform destroy
```

