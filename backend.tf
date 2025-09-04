terraform {
  backend "s3" {
    bucket = ""
    dynamodb_table = ""
    region = "ap-south-1"
    key = "terraform/terraform.tfstate"
    encrypt = true   
  }
}