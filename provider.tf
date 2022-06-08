#### AWS Provider #######

provider "aws" {
  region     = "us-east-1"
}

### Kubernetes Provider #######

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

##### Helm Provider #######

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    #     exec {
    #       api_version = "client.authentication.k8s.io/v1alpha1"
    #       args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    #       command     = "aws"
    #     }
  }
}

####### Kubectl Provider ####

terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}