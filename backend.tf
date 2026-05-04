terraform {
  backend "s3" {
    bucket         = "replace-with-your-terraform-state-bucket"
    key            = "goit-linux/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "replace-with-your-terraform-locks-table"
    encrypt        = true
  }
}

