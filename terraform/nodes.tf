resource "aws_iam_role" "nodes_role" {
  name = "${var.env}-${var.project_name}-nodes-role"

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

# The AmazonEKSWorkerNodePolicy managed policy now includes AssumeRoleForPodIdentity.
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_role.name
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  version = var.eks_version
  node_group_name = "${var.env}-${var.project_name}-nodes"
  node_role_arn   = aws_iam_role.nodes_role.arn

  subnet_ids      = [
    aws_subnet.private_zone_1.id,
    aws_subnet.private_zone_2.id
  ]

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.large"]

  scaling_config {
      desired_size = 2
      max_size     = 10
      min_size     = 1
  }

  update_config {
      max_unavailable = 1
  }

  labels = {
    role = "worker-nodes"
  }

    depends_on = [
      aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
      aws_iam_role_policy_attachment.amazon_eks_cni_policy,
      aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only
    ]

  #Allow external changes without a Terraform plan difference to avoid conflicts from scaling.
    lifecycle {
        ignore_changes = [scaling_config.0.desired_size]
    }
}