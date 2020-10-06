resource "aws_eks_cluster" "eks_cluster" {
  name     = "example"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids_eks
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
}