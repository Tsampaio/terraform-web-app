data "aws_ami" "ubuntu_latest" {
  name_regex  = "amzn2-ami-hvm-2\\.0\\.20210525\\.0-x86_64-gp2"
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              EOF
}

resource "aws_instance" "my-first-ec2-instance" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_keypair
  security_groups             = [aws_security_group.ec2-security-group.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "ec2-security-group" {
  name   = var.instance_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = [var.ssh_allowed_ip]
  }

  ingress {
    from_port   = 0
    protocol    = "-1" //all protocols
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
