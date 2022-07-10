# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.2
#

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = local.name
  cidr = "10.99.0.0/18"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
}

# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/4.9.0
#

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = local.name
  description = "Security group for Web ec2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "security_group_rds" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${local.name}-rds"
  description = "Security group for RDS db instances"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.99.0.0/18"
    }
  ]
}
