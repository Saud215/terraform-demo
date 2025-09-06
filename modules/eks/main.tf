resource "aws_iam_role" "cluster-role" {

    name = "${var.cluster_name}-cluster-role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Effect = "Allow",
        Principal = {
            Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {

    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.cluster-role.name
}

resource "aws_eks_cluster" "eks-cluster" {
  
  name = var.cluster_name
  version = var.cluster_version
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

resource "aws_iam_role" "node-role" {

    name = "${var.cluster_name}-node-role"
   assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Effect = "Allow",
        Principal = {
            Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "node_policy" {
  for_each = {
    eks_worker     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    cni            = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ecr_read_only  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }

  policy_arn = each.value
  role       = aws_iam_role.node_role.name
}

resource "aws_eks_node_group" "eks-cluster-node-group" {

    for_each = var.node_groups

    cluster_name = var.cluster_name
    node_role_arn = aws_iam_role.node-role.arn
    subnet_ids = var.subnet_ids
    
    node_group_name = each.key
    instance_types = each.value.instance_types
    capacity_type = each.value.capacity_type

    scaling_config {
      desired_size = each.value.scaling_config.desired_size
      max_size = each.value.scaling_config.max_size
      min_size = each.value.scaling_config.min_size
    }

    depends_on = [ aws_iam_role_policy_attachment.node_policy ]
}