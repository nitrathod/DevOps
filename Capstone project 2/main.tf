provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  vpc_name     = var.project_name
  project_name = var.project_name
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  vpc_name              = var.project_name
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
  public_route_table_id = module.vpc.public_route_table_id
}

module "nat_gateway" {
  source             = "./modules/nat_gateway"
  vpc_id             = module.vpc.vpc_id
  vpc_name           = var.project_name
  public_subnet_id   = element(module.subnets.public_subnets, 0) # Select the first public subnet
  private_subnet_ids = module.subnets.private_subnets            # Use all private subnets
}

module "security_groups" {
  source          = "./modules/security_groups"
  vpc_id          = module.vpc.vpc_id
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  project_name    = var.project_name
}

module "ec2_instance" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = element(module.subnets.public_subnets, 0)  # Using the first public subnet
  security_group_ids = [module.security_groups.ec2_security_group_id]  # Correct reference to the output
  instance_name     = "${var.project_name}-ec2"
  additional_tags   = {
    "Environment" = var.environment
  }
  user_data           = file("${path.module}/userdata.sh")
  root_volume_size    = 50                                        # Example of changing root volume size
  root_volume_type    = "gp2"
  disable_api_termination = false
}