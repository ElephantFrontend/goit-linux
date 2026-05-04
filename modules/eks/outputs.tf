output "cluster_name" {
  description = "Cluster name"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Cluster endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Cluster CA data"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

