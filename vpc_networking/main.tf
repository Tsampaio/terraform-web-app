resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.env_code
  }
}

resource "aws_subnet" "module_public_subnet" {
  count      = 2
  cidr_block = var.public_subnet.cidr[count.index]
  vpc_id     = aws_vpc.module_vpc.id

  tags = {
    Name = "${var.env_code}-public-${count.index}"
  }
}

resource "aws_subnet" "module_private_subnet" {
  count      = 2
  cidr_block = var.private_subnet.cidr[count.index]
  vpc_id     = aws_vpc.module_vpc.id
  # availability_zone = "${var.region}a" ???
  # availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.env_code}-private-${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name = "${var.env_code}-private"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = 2
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.module_public_subnet[count.index].id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = 2
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.module_private_subnet[count.index].id
}

resource "aws_eip" "elastic_ip_for_nat_gw" {
  count = 2
  vpc   = true

  tags = {
    Name = var.env_code
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  allocation_id = aws_eip.elastic_ip_for_nat_gw[count.index].id
  subnet_id     = aws_subnet.module_public_subnet[count.index].id

  tags = {
    Name = "${var.env_code}-${count.index}"
  }
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway[0].id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name = var.env_code
  }
}

resource "aws_route" "igw_route" {
  count                  = 2
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
