terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket-name"
    key            = "lesson-7/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

