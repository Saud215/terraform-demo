variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "dynamodb_hash_key" {
  description = "The hash key (partition key) for the DynamoDB table"
  type        = string
}
