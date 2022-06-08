data "kubernetes_ingress" "ingress_endpoint" {
  depends_on = [helm_release.nginx]
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
}

# resource "aws_route53_record" "www-dev" {

#   depends_on = [helm_release.nginx]
#   zone_id    = "Z03263951KBGAAH0G98CC"
#   name       = "testjack"
#   type       = "CNAME"
#   ttl        = "5"
#   records    = [data.kubernetes_ingress.ingress_endpoint.status.0.load_balancer.0.ingress.0.hostname]
# }