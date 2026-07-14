module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  version = "5.8.1"

  name = "${var.project_name}-${var.environment}"

  cidr = "10.0.0.0/16"

  azs = [
    "us-east-2a",
    "us-east-2b"
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway = true

  single_nat_gateway = true

  enable_dns_hostnames = true

  enable_dns_support = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

}


################################################################################
# EKS
################################################################################

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.15"

  cluster_name    = local.cluster_name
  cluster_version = "1.31"

  subnet_ids = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {

    default = {

      desired_size = 2

      min_size = 2

      max_size = 3

      instance_types = ["t3.micro"]

      capacity_type = "ON_DEMAND"

    }

  }

  tags = local.common_tags

}

################################################################################
# MongoDB Security Group
################################################################################

resource "aws_security_group" "mongodb" {
  name        = "mongodb-sg"
  description = "MongoDB Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "MongoDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

