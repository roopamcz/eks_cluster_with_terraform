##################################################################################
# LOCALS
##################################################################################

locals {
  env_name = "nonprod"
  project  = "rapidinnovation"

  ##### For EKS Only #######

  eks_cluster_name = "${local.env_name}-${local.project}-eks"

  #     map_roles = [
  #   {
  #     rolearn  = "arn:aws:iam::38733730000:role/DevOp"
  #     username = "DevOp"
  #     groups   = ["system:masters", "system:bootstrappers", "system:nodes"]
  #   },
  # ]

  map_users = [
    {
      userarn  = "arn:aws:iam::920048411410:user/jignesh@rapidinnovation.dev"
      username = "jignesh@rapidinnovation.dev"
      groups   = ["system:masters", "system:nodes"]
    },
  ]

  instance_type        = "t3.medium"
  asg_desired_capacity = 1
  asg_min_size         = 1
  asg_max_size         = 2

  capacity_type = "spot"

  ###### ACM Certificate ARN #####
  rapidinnovation_acm = "arn:aws:acm:us-east-1:920048411410:certificate/61bc08d6-bc6c-48bd-82a2-605195fde6a5"


  common_tags = {
    project             = local.project
    Environment         = local.env_name
    cost_center         = "484058"
    project_owner       = "JigneshKumar_Patel"
    project_owner_email = "jignesh@rapidinnovation.dev"
  }
}