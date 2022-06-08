resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "git@github.com:Rapid-Innovation/infra-terraform-rapidinnovation.git//nginxssl?ref=helm"
  chart      = "nginxssl"

  set {
    name  = "vpccidr"
    value = module.vpc.vpc_cidr_block
  }

  set {
    name  = "sslcertarn"
    value = local.rapidinnovation_acm
  }
}