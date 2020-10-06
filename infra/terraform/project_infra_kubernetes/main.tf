module "iam_eks" {
  source    = "../modules/iam"
  role_name = "eks-cluster"
}

module "network_eks" {
  source              = "../modules/vpc"
  project             = "Splice Network"
  environment_tag = "Dev"
  cidr_block_vpc      = "192.168.0.0/24"
  public_azs          = ["1","2"]
  public_cidr_blocks  = ["192.168.1.0/24", "192.168.2./24"]
  private_azs         = ["1","2"]
  private_cidr_blocks = ["192.168.3.0/24", "192.168.4.0/24"]
}
