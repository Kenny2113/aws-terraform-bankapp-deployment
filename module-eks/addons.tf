###############################
# EKS Auth
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
# Wait for EKS to be ACTIVE
###############################
resource "null_resource" "wait_for_eks" {
  depends_on = [aws_eks_cluster.eks]

  provisioner "local-exec" {
    command = "aws eks wait cluster-active --name ${aws_eks_cluster.eks.name} --region ${var.region}"
  }
}

###############################
# NGINX INGRESS
###############################
resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.12.0"
  namespace        = "nginx-ingress"
  create_namespace = true

  values = [file("${path.module}/nginx-ingress-values.yaml")]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    null_resource.wait_for_eks
  ]
}

###############################
# CERT MANAGER
###############################
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.14.5"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }

  depends_on = [
    helm_release.nginx_ingress
  ]
}

###############################
# ARGO CD
############
