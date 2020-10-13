resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids_eks
    security_group_ids = var.security_group_ids
  }
}
