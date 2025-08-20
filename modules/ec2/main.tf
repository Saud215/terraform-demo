resource "aws_instance" "this" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id

  tags = {

    Name = "terraform-demo-ec2"
    Description = "This ec2 instance was created using the terraform"
  }
}