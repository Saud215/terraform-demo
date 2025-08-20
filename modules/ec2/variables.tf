variable "ami_id" {

    description = "The ami id for the ec2 instance on aws"
    type = string
} 
variable "instance_type" {

    description = "The type of ec2 instance"
    type = string
}  
variable "subnet_id" {

    description = "The subnet id for the ec2 instance"
    type = string
}  