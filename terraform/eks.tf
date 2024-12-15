resource "aws_iam_role" "eks_role" {
  name               = "${var.env}-${var.project_name}-eks-cluster-role"

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

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.env}-${var.project_name}"
  version  = var.eks_version
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.private_zone_1.id,
      aws_subnet.private_zone_2.id
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

    depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}