provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "this_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.cluster_name}-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"

  }
}

resource "aws_subnet" "public_this" {
count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.this_vpc.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true
    
  tags = {
    Name = "${var.cluster_name}-public-subnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}"    = "shared"
    "kubernetes.io/role/elb"                       = "1"

  }
}

resource "aws_subnet" "private_this" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.this_vpc.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    
  tags = {
    Name = "${var.cluster_name}-private-subnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}"    = "shared"
    "kubernetes.io/role/internal-elb"              = "1"
  }
}

resource "aws_internet_gateway" "igw_this" {
vpc_id = aws_vpc.this_vpc.id

tags = {

    Name = "${var.cluster_name}-igw"
}
}

resource "aws_eip" "natgw_eip" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "${var.cluster_name}-natgw-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "natgw_this" {
 count = length(var.public_subnet_cidrs)
 allocation_id = aws_eip.natgw_eip[count.index].id
 subnet_id = aws_subnet.public_this[count.index].id

 tags = {
   Name = "${var.cluster_name}-natgw-${count.index + 1}"
 }
}
  
resource "aws_route_table" "public_route_table_this" {
  vpc_id = aws_vpc.this_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_this.id
  }

  tags = {
    Name = "${var.cluster_name}-public-route-table"
  }
}

resource "aws_route_table" "private_route_table_this" {

  count = length(var.public_subnet_cidrs) 
  vpc_id = aws_vpc.this_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw_this[count.index].id
  }

  tags = {
    Name = "${var.cluster_name}-private-route-table-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_route_table_association" {

    count = length(var.public_subnet_cidrs)
    route_table_id = aws_route_table.public_route_table_this.id
    subnet_id = aws_subnet.public_this[count.index].id
}

resource "aws_route_table_association" "private_route_table_association" {

    count = length(var.private_subnet_cidrs)
    route_table_id = aws_route_table.private_route_table_this[count.index].id
    subnet_id = aws_subnet.private_this[count.index].id
}
