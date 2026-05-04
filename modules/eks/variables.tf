variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for control plane"
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Subnet IDs for node group"
  type        = list(string)
}

variable "node_group_desired_size" {
  description = "Desired node count"
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum node count"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum node count"
  type        = number
}

variable "node_instance_types" {
  description = "Node instance types"
  type        = list(string)
}

