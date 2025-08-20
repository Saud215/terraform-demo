output "instance_id" {
    description = "The ID of the instance returned after the instance is successfully created"
 value =  aws_instance.this.id  
}
output "public_ip" {
    description = "The public ip of the instance returned after the instance is successfully created"
 value =  aws_instance.this.public_ip
}
  