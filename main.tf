module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  aws_region      = var.aws_region
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  instance_type     = var.instance_type
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.app_sg
}

module "infra_services" {
  source = "./modules/infra-services"

  ec2_instance     = module.ec2
  ec2_public_ip    = module.ec2.public_ip
  private_key_path = var.private_key_path
}


module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = module.vpc.private_subnet_ids
  node_groups     = var.node_groups
}


/*module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  security_group_id  = module.security_groups.db_sg
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  target_instance_id = module.ec2.instance_id
  security_group_id  = module.security_groups.lb_sg
}
*/