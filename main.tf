provider "aws" {
  region = var.region
}

module "vpc_networking" {
  source         = "./vpc_networking"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
  env_code       = var.env_code
}

module "ec2-private" {
  source                      = "./ec2"
  subnet_id                   = module.vpc_networking.private_subnets[0].id
  vpc_cidr_block              = var.vpc_cidr_block
  ec2_instance_type           = var.ec2_instance_type
  ec2_keypair                 = var.ec2_keypair
  ssh_allowed_ip              = var.ssh_allowed_ip
  associate_public_ip_address = false
  instance_name               = "private"
  vpc_id                      = module.vpc_networking.vpc_id
}

module "ec2-public" {
  source                      = "./ec2"
  subnet_id                   = module.vpc_networking.public_subnets[0].id
  vpc_cidr_block              = var.vpc_cidr_block
  ec2_instance_type           = var.ec2_instance_type
  ec2_keypair                 = var.ec2_keypair
  ssh_allowed_ip              = var.ssh_allowed_ip
  associate_public_ip_address = true
  instance_name               = "public"
  vpc_id                      = module.vpc_networking.vpc_id
}
