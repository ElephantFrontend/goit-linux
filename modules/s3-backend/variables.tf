variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name override"
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name override"
  type        = string
  default     = ""
}

