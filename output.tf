###### VPC Output #####

output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}

##### Kubernetes Output ########

output "k8s_cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = module.eks.cluster_id
}

output "k8s_cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "k8s_kubeconfig" {
  description = "kubectl config file contents for this EKS cluster."
  value       = module.eks.kubeconfig
}

