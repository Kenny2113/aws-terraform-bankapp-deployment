###############################
# EKS Authentication
###############################
data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}

###############################
# Kubernetes Provider (Required)
###############################
provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

###############################
# Helm Provider (Required)
###############################
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

###############################
# Install kubectl Automatically
########
