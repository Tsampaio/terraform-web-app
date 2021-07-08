# data "aws_ami" "ubuntu_latest" {
#   name_regex  = "amzn2-ami-hvm-2\\.0\\.20210525\\.0-x86_64-gp2"
#   owners      = ["amazon"]
#   most_recent = true

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

# }

resource "aws_instance" "my-first-ec2-instance" {
  # ami                         = data.aws_ami.ubuntu_latest.id
  ami                         = var.aws_ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_keypair
  security_groups             = [var.security_groups]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = var.instance_name
  }
}
