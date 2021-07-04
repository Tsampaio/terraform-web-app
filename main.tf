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

module "auto_scale_module" {
  source                 = "./auto_scale_group"
  env_code               = var.env_code
  ec2_instance_type      = var.ec2_instance_type
  ec2_keypair            = var.ec2_keypair
  autoscaling_group_name = var.autoscaling_group_name
  security_groups        = module.ec2-public.security_groups
  vpc_private_subnet_id  = module.vpc_networking.private_subnets[0].id
  max_size_group         = var.max_size_group
  min_size_group         = var.min_size_group
  load_balancers         = var.load_balancers
  force_delete           = var.force_delete
  propagate_at_launch    = var.propagate_at_launch
}



// terraform init
// terraform plan --var-file=production.tfvars
// terraform apply --var-file=production.tfvars
// ssh ec2-user@35.177.197.241 -i my-first-ec2-instance.pem to SHH login
// terraform destroy --var-file=production.tfvars
// terraform fmt -recursive to format the code at top level of repo
