##################################################################################
# RESOURCES
##################################################################################
###### NETWORKING #
module "vpc" {
  source = "git@github.com:Rapid-Innovation/infra-terraform-rapidinnovation.git//vpc?ref=modules"

  name = "${local.env_name}-${local.project}-vpc"
  cidr = "10.0.0.0/16"

  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"
    "karpenter.sh/discovery"                          = local.eks_cluster_name
  }

  tags = merge(
    local.common_tags,
    {
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    },
  )
}
