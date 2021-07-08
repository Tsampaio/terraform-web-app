data "aws_ami" "ubuntu_latest" {
  name_regex  = "amzn2-ami-hvm-2\\.0\\.20210525\\.0-x86_64-gp2"
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
