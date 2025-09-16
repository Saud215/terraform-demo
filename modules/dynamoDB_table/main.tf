resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST" # no need to manage capacity
  hash_key     = var.dynamodb_hash_key #"LockID"

  attribute {
    name = var.dynamodb_hash_key #"LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Locks Table"
    Environment = "Dev"
  }
}
