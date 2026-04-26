variable "ecr_name" {
  description = "Name of ECR repository"
  type        = string
}

variable "scan_on_push" {
  description = "Enable image scan on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "MUTABLE"
}

variable "allowed_principal_arns" {
  description = "List of IAM principal ARNs allowed to push/pull images"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}
