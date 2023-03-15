####Createing EKS Cluster
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}



module "eks" {
  source          = "./eks"
  cluster_name    = local.eks_cluster_name
  cluster_version = "1.25"
  subnets         = module.vpc.private_subnets
  enable_irsa     = true
  # subnets         = concat(module.vpc.private_subnets,module.vpc.public_subnets)
  vpc_id = module.vpc.vpc_id

  tags = merge(
    local.common_tags,
    {
      "kubernetes.io/cluster/${local.eks_cluster_name}"     = "shared"
      "karpenter.sh/discovery"                              = local.eks_cluster_name
      "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"                   = "true"
    },
  )
  #   map_roles = var.map_roles
  #   map_users = var.map_users

  worker_groups = [
    {
      name                 = "worker-grp-01"
      instance_type        = local.instance_type
      asg_desired_capacity = local.asg_desired_capacity
      asg_min_size         = local.asg_min_size
      asg_max_size         = local.asg_max_size
      # additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]

}