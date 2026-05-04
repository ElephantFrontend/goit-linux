locals {
  resolved_table_name = var.dynamodb_table_name != "" ? var.dynamodb_table_name : "${var.project_name}-${var.environment}-tf-locks"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = local.resolved_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

