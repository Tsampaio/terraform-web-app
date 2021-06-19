output "vpc_cidr" {
  value = module.vpc_networking.vpc_cidr
}

output "public_subnet_cidr" {
  value = module.vpc_networking.public_subnet_cidr
}

output "private_subnet_cidr" {
  value = module.vpc_networking.private_subnet_cidr
}
