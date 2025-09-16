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

module "eks_cluster" {

  source = "./modules/eks"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  node_groups = var.node_groups
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks_cluster.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks_cluster.cluster_name
}
