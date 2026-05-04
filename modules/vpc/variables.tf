variable "name" {
  description = "Name prefix"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "az_count" {
  description = "How many availability zones to use"
  type        = number
  default     = 2
}

