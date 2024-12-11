### Control Plane Nodes IAM Role configuration ###
resource "aws_iam_role" "control_plane_nodes_role" {
  name = "IaC_Demo-control_plane_nodes_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.control_plane_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  role       = aws_iam_role.control_plane_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  role       = aws_iam_role.control_plane_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


### Worker Nodes IAM Role configuration ###
resource "aws_iam_role" "worker_nodes_role" {
  name = "IaC_Demo-worker_nodes_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AutoScalingFullAccess" {
  role       = aws_iam_role.worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
}

resource "aws_iam_instance_profile" "worker_nodes_profile" {
  role       = aws_iam_role.worker_nodes_role.name
  name       = "IaC_Demo-worker_nodes_profile"
  depends_on = [aws_iam_role.worker_nodes_role]
}


### EKS Cluster Configuration ###
resource "aws_eks_cluster" "my_eks_cluster" {
  name     = "IaC_Demo-my_eks_cluster"
  role_arn = aws_iam_role.control_plane_nodes_role.arn
    vpc_config {
      subnet_ids = var.private_subnets
      security_group_ids = [var.worker_node_security_group_id]
      endpoint_public_access = true
      endpoint_private_access = false
    }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator","controllerManager","scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

  tags = {
    Name = "EKS Cluster ${var.tags_name}"
  }
}

### EKS Node Group Configuration ###
resource "aws_eks_node_group" "my_eks_node_group" {
  cluster_name    = aws_eks_cluster.my_eks_cluster.name
  node_group_name = "dev"
  node_role_arn   = aws_iam_role.worker_nodes_role.arn
  subnet_ids = var.private_subnets
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.small"]

  labels =  tomap({env = "dev"})

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AutoScalingFullAccess,
  ]

  tags = {
    Name = "EKS Worker Node ${var.tags_name}"
  }
}