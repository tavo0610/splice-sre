module "iam_eks" {
  source    = "../modules/iam"
  role_name = "eks-cluster"
}

module "network_eks" {
  source              = "../modules/vpc"
  project             = "Splice"
  environment_tag     = "${terraform.workspace}"
  cidr_block_vpc      = "192.168.0.0/16"
  public_azs          = ["us-west-2a", "us-west-2b"]
  public_cidr_blocks  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_azs         = ["us-west-2a", "us-west-2b"]
  private_cidr_blocks = ["192.168.3.0/24", "192.168.4.0/24"]
  name_sg             = "SG EKS"
  sg_eks_inbound      = ["201.141.86.214/32"]
  nat_gw_subnet       = "us-west-2a"
}

module "eks" {
  source             = "../modules/eks"
  cluster_name       = "Demo-Cluster"
  role_arn           = module.iam_eks.role_arn
  subnet_ids_eks     = values(module.network_eks.subnet_private_ids)
  vpc_cluster_id     = module.network_eks.vpc_id
  security_group_ids = ["${module.network_eks.security_group_ids}"]
}
