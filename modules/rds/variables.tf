variable "name" {
  description = "Base name used for RDS/Aurora resources"
  type        = string
}

variable "use_aurora" {
  description = "If true create Aurora cluster, otherwise create single RDS instance"
  type        = bool
  default     = true
}

variable "engine" {
  description = "Database engine (for example: aurora-postgresql, postgres, mysql)"
  type        = string

  validation {
    condition     = var.use_aurora ? can(regex("^aurora-", var.engine)) : !can(regex("^aurora-", var.engine))
    error_message = "When use_aurora=true engine must start with 'aurora-'; when false it must be a standard RDS engine."
  }
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
}

variable "database_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID where DB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for DB subnet group"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that can access the DB port"
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security groups that can access the DB port"
  type        = list(string)
  default     = []
}

variable "port" {
  description = "DB port"
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Enable Multi-AZ for non-Aurora RDS"
  type        = bool
  default     = false
}

variable "allocated_storage" {
  description = "Allocated storage in GB for non-Aurora RDS"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type for non-Aurora RDS"
  type        = string
  default     = "gp3"
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public endpoint"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = true
}

variable "parameter_group_family" {
  description = "Optional DB parameter group family override"
  type        = string
  default     = null

  validation {
    condition = var.parameter_group_family != null || contains([
      "postgres",
      "aurora-postgresql",
      "mysql",
      "aurora-mysql"
    ], var.engine)
    error_message = "Set parameter_group_family when using engines outside postgres/mysql/aurora-postgresql/aurora-mysql."
  }
}

variable "db_parameters" {
  description = "List of DB parameters"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "pending-reboot")
  }))
  default = [
    {
      name         = "max_connections"
      value        = "200"
      apply_method = "pending-reboot"
    },
    {
      name         = "log_statement"
      value        = "ddl"
      apply_method = "immediate"
    },
    {
      name         = "work_mem"
      value        = "4096"
      apply_method = "pending-reboot"
    }
  ]
}

variable "apply_immediately" {
  description = "Apply modifications immediately"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}


