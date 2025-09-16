terraform {
  backend "s3" {
    bucket = ""
    dynamodb_table = ""
    region = ""
    key = "terraform/terraform.tfstate"
    encrypt = true   
  }
}
