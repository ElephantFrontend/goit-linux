variable "repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "image_tag_mutability" {
  description = "Tag mutability mode"
  type        = string
  default     = "MUTABLE"
}

