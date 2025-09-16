output "s3_bucket_arn" {
    
    description = "The amazon resource number returned after successful creation of s3 bucket"
    value = aws_s3_bucket.this.arn
}

output "s3_bucket_name" {

    description = "The bucket name returned after successful creation of s3 bucket"  
    value = aws_s3_bucket.this.bucket
}

