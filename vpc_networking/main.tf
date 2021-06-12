provider "aws" {
  region = var.region
}

resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags {
    Name = "Production-VPC"
  }
}

resource "aws_subnet" "module_public_subnet_1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"

  tags {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "module_public_subnet_2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}b"

  tags {
    Name = "Public-Subnet-2"
  }
}
