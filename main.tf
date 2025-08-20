provider "aws" {
    region = "ap-south-1"
}

module "ec2_instance" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
}

module "s3_bucket" {

    source = "./modules/s3"
    bucket_name = var.bucket_name
} 

output "ec2_id" {
    value = module.ec2_instance.instance_id
}
output "ec2_public_ip" {
    value = module.ec2_instance.public_ip
}
output "s3_arn" {
    value = module.s3_bucket.bucket_arn
}

  