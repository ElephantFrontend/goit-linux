variable "identifier_prefix" {
  description = "Identifier prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDRs allowed to connect to DB"
  type        = list(string)
  default     = []
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "create_rds_instance" {
  description = "Create single RDS instance"
  type        = bool
  default     = true
}

variable "create_aurora" {
  description = "Create Aurora cluster"
  type        = bool
  default     = false
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage (GB)"
  type        = number
  default     = 20
}

variable "rds_engine_version" {
  description = "RDS Postgres version"
  type        = string
  default     = "16.3"
}

variable "aurora_instance_class" {
  description = "Aurora instance class"
  type        = string
  default     = "db.t4g.medium"
}

variable "aurora_instance_count" {
  description = "Aurora instance count"
  type        = number
  default     = 1
}

variable "aurora_engine_version" {
  description = "Aurora Postgres engine version"
  type        = string
  default     = "15.4"
}

