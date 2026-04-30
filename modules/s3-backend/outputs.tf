output "s3_bucket_url" {
  description = "S3 URL of the Terraform state bucket"
  value       = "s3://${aws_s3_bucket.terraform_state.id}"
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

