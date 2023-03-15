Before tun this Terraform Script run this command.

aws iam create-service-linked-role --aws-service-name spot.amazonaws.com || true

We need to install Karpenter manually with this 
Command --> helm upgrade --install --namespace karpenter --create-namespace karpenter karpenter/karpenter  --version v0.16.3  --set serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn=${KARPENTER_IAM_ROLE_ARN}  --set clusterName=${CLUSTER_NAME}  --set clusterEndpoint=${CLUSTER_ENDPOINT}  --set aws.defaultInstanceProfile=KarpenterNodeInstanceProfile-${CLUSTER_NAME}  --wait

Also need to deploy Provisoners with this
nano provisoners.yml
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: default
  spec:
    requirements:
      - key: karpenter.sh/capacity-type
        operator: In
        values: [spot]
    limits:
      resources:
        cpu: 30
    provider:
      subnetSelector:
        karpenter.sh/discovery: "nonprod-rapidinnovation-eks"
      securityGroupSelector:
        karpenter.sh/discovery: "nonprod-rapidinnovation-eks"
      tags:
        karpenter.sh/discovery: "nonprod-rapidinnovation-eks"
    ttlSecondsAfterEmpty: 30

kubectl create -f proviosoners.yml -n karpenter

All Set |||
