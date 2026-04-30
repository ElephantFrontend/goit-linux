variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs (must contain 3 CIDRs)"
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) == 3
    error_message = "Exactly 3 public subnets are required."
  }
}

variable "private_subnets" {
  description = "List of private subnet CIDRs (must contain 3 CIDRs)"
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) == 3
    error_message = "Exactly 3 private subnets are required."
  }
}

variable "availability_zones" {
  description = "List of availability zones (must contain 3 AZs)"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 3
    error_message = "Exactly 3 availability zones are required."
  }
}

variable "vpc_name" {
  description = "Name tag for VPC"
  type        = string
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}

