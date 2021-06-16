# aws ec2 create-key-pair --key-name my-first-ec2-instance --region eu-west-2 --query 'KeyMaterial' --output text > my-first-ec2-instance.pem
# resource "aws_key_pair" "" {
#   public_key = ""
# }

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

data "aws_ami" "ubuntu_latest" {
  owners = ["099720109477"]
  most_recent = true

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "my-first-ec2-instance" {
  ami = data.aws_ami.ubuntu_latest.id
  instance_type = var.ec2_instance_type
  key_name = var.ec2_keypair
  security_groups = [aws_security_group.ec2-security-group.id]
  subnet_id = aws_subnet.module_public_subnet.id

  # user_data = "" our custom script to run when the instance is created
}

resource "aws_security_group" "ec2-security-group" {
  name = "EC2-Instance-SG"
  vpc_id = aws_vpc.module_vpc.id

  ingress {
    from_port = 0
    protocol = "-1" //all traffic from aws
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1" //all traffic from aws
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}