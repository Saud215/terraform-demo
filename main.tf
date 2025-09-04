provider "aws" {
    region = "ap-south-1"
}

  module "vpc" {
source = "./modules/vpc"
vpc_cidr = var.vpc_cidr
public_subnet_cidrs = var.public_subnet_cidrs
private_subnet_cidrs = var.private_subnet_cidrs
availability_zones = var.availability_zones
cluster_name = var.cluster_name   
  }