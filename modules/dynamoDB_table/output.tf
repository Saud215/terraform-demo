output "dynamodb_table_arn" {

    description = "The amazon resource number returned after successful creation of dynamoDB table"
    value = aws_dynamodb_table.this.arn
}

output "dynamodb_table_name" {

     description = "The table name returned after successful creation of dynamoDB table"  
    value = aws_dynamodb_table.this.name
}

