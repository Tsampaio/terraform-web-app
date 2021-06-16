module "vpc_networking" {
  source = "./vpc_networking"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
  eip_association_address = var.eip_association_address
}

module "ec2" {
  source = "./ec2"
  vpc_cidr_block = var.vpc_cidr_block
  ec2_instance_type = var.ec2_instance_type
  ec2_keypair = var.ec2_keypair
}

// terraform init
// terraform plan --var-file=production.tfvars
// terraform apply --var-file=production.tfvars