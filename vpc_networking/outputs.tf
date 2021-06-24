output "public_subnets" {
  value = aws_subnet.module_public_subnet
}

output "private_subnets" {
  value = aws_subnet.module_private_subnet
}

output "vpc_id" {
  value = aws_vpc.module_vpc.id
}
