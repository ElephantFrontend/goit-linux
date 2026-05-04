terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3_backend" {
  count = var.create_backend_resources ? 1 : 0

  source              = "./modules/s3-backend"
  project_name        = var.project_name
  environment         = var.environment
  bucket_name         = var.backend_bucket_name
  dynamodb_table_name = var.backend_dynamodb_table_name
}

module "vpc" {
  source = "./modules/vpc"

  name       = "${var.project_name}-${var.environment}"
  cidr_block = var.vpc_cidr
  az_count   = var.az_count
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "${var.project_name}-${var.environment}-django"
}

module "eks" {
  source = "./modules/eks"

  cluster_name      = "${var.project_name}-${var.environment}-eks"
  kubernetes_version = var.kubernetes_version
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  node_subnet_ids   = module.vpc.public_subnet_ids

  node_group_desired_size = var.node_group_desired_size
  node_group_min_size     = var.node_group_min_size
  node_group_max_size     = var.node_group_max_size
  node_instance_types     = var.node_instance_types
}

module "rds" {
  source = "./modules/rds"

  identifier_prefix  = "${var.project_name}-${var.environment}"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  allowed_cidr_blocks = [var.vpc_cidr]

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  create_rds_instance = var.create_rds_instance
  create_aurora       = var.create_aurora
}

module "jenkins" {
  source = "./modules/jenkins"

  cluster_endpoint        = module.eks.cluster_endpoint
  cluster_ca_certificate  = module.eks.cluster_certificate_authority_data
  cluster_name            = module.eks.cluster_name
  namespace               = "jenkins"
  jenkins_chart_version   = var.jenkins_chart_version

  depends_on = [module.eks]
}

module "argo_cd" {
  source = "./modules/argo_cd"

  cluster_endpoint        = module.eks.cluster_endpoint
  cluster_ca_certificate  = module.eks.cluster_certificate_authority_data
  cluster_name            = module.eks.cluster_name
  argocd_chart_version    = var.argocd_chart_version
  monitoring_chart_version = var.monitoring_chart_version

  depends_on = [module.eks]
}

