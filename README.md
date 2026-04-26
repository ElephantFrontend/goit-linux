# lesson-5 Terraform Infrastructure

Проєкт створює:
1. Backend для Terraform state: S3 + DynamoDB lock
2. VPC з 3 публічними і 3 приватними підмережами
3. ECR репозиторій для Docker-образів

## Структура проєкту

- `main.tf` — підключення модулів
- `backend.tf` — конфігурація S3 backend
- `outputs.tf` — загальні outputs
- `modules/s3-backend` — S3 bucket + DynamoDB table
- `modules/vpc` — VPC, subnet'и, IGW, NAT, route tables
- `modules/ecr` — ECR репозиторій, scanning, policy

## Важливо: bootstrap backend

Terraform не може одночасно:
- використовувати S3 backend
- і створювати цей самий S3 bucket/DynamoDB у тій же самій ініціалізації

Рекомендований порядок:
1. Тимчасово закоментувати `backend "s3"` у `backend.tf`
2. Запустити apply локально (створити bucket/table)
3. Розкоментувати `backend "s3"` і виконати `terraform init -migrate-state`

## Команди

```bash
terraform init
terraform plan
terraform apply
terraform destroy
