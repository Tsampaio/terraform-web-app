provider "aws" {
  region = var.region
}

resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "AWS-VPC-Training"
  }
}

resource "aws_subnet" "module_public_subnet" {
  count = 2
  cidr_block        = var.public_subnet.cidr[count.index]
  vpc_id            = aws_vpc.module_vpc.id

  tags = {
    Name = "Public-Subnet-${count.index}"
  }
}

resource "aws_subnet" "module_private_subnet" {
  count = 2
  cidr_block        = var.private_subnet.cidr[count.index]
  vpc_id            = aws_vpc.module_vpc.id
  # availability_zone = "${var.region}a" ???
  tags = {
    Name = "Private-Subnet-${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name = "Private-Route-Table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count = 2
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet[count.index].id
}

resource "aws_route_table_association" "private_subnet_association" {
  count = 2
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet[count.index].id
}


resource "aws_eip" "elastic_ip_for_nat_gw" {
  count = 2
  vpc = true
  associate_with_private_ip = var.eip_association_address

  tags = {
    Name = "Production-EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = 2
  allocation_id = aws_eip.elastic_ip_for_nat_gw[count.index].id
  subnet_id = aws_subnet.module_public_subnet[count.index].id

  tags = {
    Name = "Production-NAT-GW"
  }
}

resource "aws_route" "nat_gateway_route" {
  count = 2
  route_table_id = aws_route_table.private_route_table.id
  nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name = "Production_IGW"
  }
}

resource "aws_route" "igw_route" {
  count = 2
  route_table_id = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

output "vpc_cidr" {
  value = aws_vpc.module_vpc.cidr_block
}

output "public_subnet_1_cidr" {
  value = aws_subnet.module_public_subnet_1.cidr_block
}

output "private_subnet_1_cidr" {
  value = aws_subnet.module_private_subnet_1.cidr_block
}