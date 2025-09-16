variable "vpc_cidr" {

    description = "The cidr block value of our VPC"
    type = string
}
variable "public_subnet_cidrs" {

    description = "The cidr blocks for our public subnets inside our VPC"
    type = list(string)
}
variable "private_subnet_cidrs" {

    description = "The cidr blocks for our private subnets inside our VPC"
    type = list(string)
}
variable "availability_zones" {

    description = "The availability zones for our subnets"
    type = list(string)
}

variable "cluster_name" {

    description = "The name of our EKS cluster"
    type = string 
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}
