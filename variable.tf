# ==============================
# 🔹 VPC + NETWORK VARIABLES
# ==============================

variable "vpc_cidrblock" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
  default     = "staging"
}

variable "create_subnet" {
  description = "Toggle subnet creation"
  type        = bool
  default     = true
}

variable "countsub" {
  description = "Number of subnets to create"
  type        = number
  default     = 2
}

variable "create_elastic_ip" {
  description = "Toggle Elastic IP"
  type        = bool
  default     = true
}

# ==============================
# 🔹 EKS CLUSTER CONFIG
# ==============================

variable "desired_size" {
  type        = number
  default     = 2
  description = "Desired node count"
}

variable "max_size" {
  type        = number
  default     = 6
  description = "Max nodes in cluster"
}

variable "min_size" {
  type        = number
  default     = 2
  description = "Minimum nodes"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t2.micro"]
  description = "EKS worker node instance type"
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "Capacity purchase type"
}

variable "eks_version" {
  type        = string
  default     = "1.32"
  description = "Cluster version"
}

variable "ami_type" {
  type        = string
  default     = "AL2_x86_64"
  description = "Node AMI architecture"
}

variable "label_one" {
  type        = string
  default     = "system"
  description = "Node label"
}

# ==============================
# 🔹 DOMAIN + NAMECHEAP SETTINGS
# ==============================

variable "zone_name" {
  type        = string
  default     = "example.com"
  description = "DNS zone name"
}

variable "domain-name" {
  type        = string
  default     = "myapp.example.com"
  description = "App domain"
}

# =============== YOUR IDENTITY ADDED HERE ==================

variable "namecheap_api_user" {
  type        = string
  default     = "Keny2113"   # 🔥 Updated — yours
}

variable "namecheap_api_key" {
  type        = string
  default     = "REPLACE_FROM_GITHUB_SECRET" # ❗ KEEP SECRET — DO NOT PUSH
}

variable "namecheap_username" {
  type        = string
  default     = "Keny2113"  # 🔥 Updated — yours
}

variable "namecheap_client_ip" {
  type        = string
  default     = "YOUR_PUBLIC_IP_HERE"   # Enter real IP later
}

# ==============================
# 🔹 RDS DATABASE SETTINGS
# ==============================

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Database compute capacity"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
  description = "Storage size (GB)"
}

variable "db_username" {
  type        = string
  default     = "admin"
  description = "DB login username"
}

variable "db_password" {
  type        = string
  default     = "REPLACE_FROM_GITHUB_SECRET"  # ❗ MUST NOT BE IN CODE
  sensitive   = true
}

variable "db_name" {
  type        = string
  default     = "production_db"
  description = "Database name"
}

# ==============================
# 🔹 MISC VARIABLES
# ==============================

variable "cluster_name" {
  type        = string
  default     = "eks-cluster"
}

variable "repository_name" {
  type        = string
  default     = "eks-repository"
}

variable "email" {
  type        = string
  default     = "kenedynwachukwu@gmail.com"   # 🔥 Updated — yours
  description = "Notification email"
}
