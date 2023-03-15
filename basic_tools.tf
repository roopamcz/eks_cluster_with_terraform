##### Node Termination ########

resource "helm_release" "node_termination" {
  name       = "node-termination"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-node-termination-handler"
  namespace  = "kube-system"

  set {
    name  = "enableSpotInterruptionDraining"
    value = "true"
  }

  set {
    name  = "enableRebalanceMonitoring"
    value = "true"
  }
}

###### AWS Metrics Server ########

resource "helm_release" "metric-server" {
  name       = "metrics"
  repository = "./charts"
  chart      = "metrics_server"
  namespace  = "kube-system"

  set {
    name  = "enableSpotInterruptionDraining"
    value = "true"
  }

  set {
    name  = "enableRebalanceMonitoring"
    value = "true"
  }
}