terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "your-unique-terraform-state-bucket-name"
  table_name  = "terraform-locks"

  tags = {
    Project = "lesson-7"
    Module  = "s3-backend"
  }
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "lesson-7-vpc"

  tags = {
    Project = "lesson-7"
    Module  = "vpc"
  }
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-django"
  scan_on_push = true

  tags = {
    Project = "lesson-7"
    Module  = "ecr"
  }
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = "lesson-7-eks"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnet_ids
  vpc_id          = module.vpc.vpc_id

  desired_size   = 2
  min_size       = 2
  max_size       = 6
  instance_types = ["t3.medium"]

  tags = {
    Project = "lesson-7"
    Module  = "eks"
  }
}

module "jenkins" {
  source                             = "./modules/jenkins"
  cluster_name                       = module.eks.cluster_name
  cluster_endpoint                   = module.eks.cluster_endpoint
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  admin_password                     = var.jenkins_admin_password

  depends_on = [module.eks]
}

module "argo_cd" {
  source                             = "./modules/argo_cd"
  cluster_name                       = module.eks.cluster_name
  cluster_endpoint                   = module.eks.cluster_endpoint
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  app_repo_url                       = var.argocd_app_repo_url
  app_repo_path                      = var.argocd_app_repo_path
  app_target_revision                = var.argocd_app_target_revision
  repo_username                      = var.argocd_repo_username
  repo_password                      = var.argocd_repo_password

  depends_on = [module.eks]
}

