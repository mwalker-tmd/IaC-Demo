variable "ec2_assume_role_policy" {
  description = "IAM assume role policy for the worker nodes"
  type        = string
  default = <<POLICY
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


### Control Plane Nodes IAM Role configuration ###
resource "aws_iam_role" "control_plane_nodes_role" {
  name = "IaC_Demo-control_plane_nodes_role"
  assume_role_policy = var.ec2_assume_role_policy
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
  assume_role_policy = var.ec2_assume_role_policy
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
      endpoint_public_access = false
    }

  encryption_config {
    resources = ["secrets"]
  }
  create_kms_key = true
  cluster_encryption_config = [{
    resources = ["secrets"]
  }]
  kms_key_description = "KMS key for EKS cluster"
  kms_key_enable_default_policy = true

  enabled_cluster_log_types = ["api", "audit", "authenticator","controllerManager","scheduler"]

  tags = {
    Name = "EKS Cluster ${var.tags_name}"
  }
}
