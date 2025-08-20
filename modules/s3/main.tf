resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {

    Name = "terraform-demo-bucket"
    Description = "This bucket was created using the terraform"
  } 
}