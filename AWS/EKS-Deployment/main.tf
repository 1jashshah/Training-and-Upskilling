# module "vpc" {
#   source = "./modules/vpc"

#   vpc_cidr               = var.vpc_cidr
#   azs                    = var.azs
#   public_subnet_cidrs    = var.public_subnet_cidrs
#   private_subnet_cidrs   = var.private_subnet_cidrs
#   tags                   = var.tags
# }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "20.0.0"

#   cluster_name    = var.cluster_name
#   cluster_version = "1.33"
#   cluster_tags    = var.tags

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

#   eks_managed_node_groups = {
#     default = {
#       desired_size   = var.desired_capacity
#       max_size       = var.desired_capacity + 1
#       min_size       = 1
#       instance_types = [var.node_instance_type]
#       ami_type = "AL2023_x86_64_STANDARD"
#     }
#   }
#   access_entries = {
#     # Give current user full access
#     "eks-admin" = {
#       principal_arn = "arn:aws:iam::490909520477:user/jamesbond"
#       policy_associations = {
#         admin = {
#           policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#         }
#       }
#     }
#   }

#   tags = var.tags
# }

# module "rds" {
#   source = "./modules/rds"

#   vpc_security_group_ids = [module.vpc.default_security_group_id]
#   db_username            = var.db_username
#   db_password            = var.db_password
#   allocated_storage      = var.db_allocated_storage
#   tags                   = var.tags
#   subnet_ids             = module.vpc.private_subnets
# }


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.31" # ✅ Supported by AWS
  cluster_tags    = var.tags

  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  eks_managed_node_groups = {
    default = {
      desired_size   = var.desired_capacity
      max_size       = var.desired_capacity + 1
      min_size       = 1
      instance_types = [var.node_instance_type]
      ami_type       = "AL2023_x86_64_STANDARD"
    }
  

  }

  tags = var.tags
}

module "rds" {
  source = "./modules/rds"

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_username            = var.db_username
  db_password            = var.db_password
  allocated_storage      = var.db_allocated_storage
  subnet_ids             = module.vpc.private_subnets
  tags                   = var.tags
}
