module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

  availability_zones = var.availability_zones

  common_tags = local.common_tags

}

module "security_groups" {

  source = "./modules/security_groups"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  ssh_allowed_cidr = var.ssh_allowed_cidr

  common_tags = local.common_tags

}

module "ec2" {

  source = "./modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  instance_type = var.instance_type
  key_name      = var.key_name

  private_subnet_id = module.vpc.private_subnet_ids[0]

  security_group_id = module.security_groups.ec2_sg_id

  github_repo = var.github_repo

  db_password       = var.db_password
  rabbitmq_user     = var.rabbitmq_user
  rabbitmq_password = var.rabbitmq_password

  common_tags = local.common_tags
}

module "alb" {

  source = "./modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_security_group_id = module.security_groups.alb_sg_id

  instance_ids = [
    module.ec2.instance_id
  ]

  common_tags = local.common_tags

}