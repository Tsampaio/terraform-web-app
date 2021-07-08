# data "aws_ami" "ubuntu_latest" {
#   name_regex  = "amzn2-ami-hvm-2\\.0\\.20210525\\.0-x86_64-gp2"
#   owners      = ["amazon"]
#   most_recent = true

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

# }

resource "aws_launch_configuration" "aws_launch_config" {
  name_prefix = "${var.env_code}-launchconfig"
  # image_id        = data.aws_ami.ubuntu_latest.id
  image_id        = var.aws_ami_id
  instance_type   = var.ec2_instance_type
  key_name        = var.ec2_keypair
  security_groups = [var.security_groups]
  user_data       = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd git
              git clone https://github.com/gabrielecirulli/2048
              cp -R 2048/* /var/www/html/
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = var.autoscaling_group_name
  vpc_zone_identifier  = [var.vpc_private_subnet_id]
  launch_configuration = aws_launch_configuration.aws_launch_config.name

  max_size       = var.max_size_group
  min_size       = var.min_size_group
  load_balancers = [var.load_balancers]
  force_delete   = var.force_delete

  tag {
    key                 = var.autoscaling_group_name
    propagate_at_launch = var.propagate_at_launch
    value               = var.auto_scale_group_instance
  }
}
