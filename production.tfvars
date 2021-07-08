vpc_cidr_block = "10.0.0.0/16"

public_subnet = {
  cidr = ["10.0.1.0/24", "10.0.2.0/24"]
}

private_subnet = {
  cidr = ["10.0.3.0/24", "10.0.4.0/24"]
}

ec2_keypair = "my-first-ec2-instance"

ec2_instance_type = "t2.micro"

ssh_allowed_ip = "86.11.241.39/32"

region = "eu-west-2"

env_code = "prod"

autoscaling_group_name = "apache_web_app_autoscaling_group"

auto_scale_group_instance = "ec2 instance"

min_size_group = 1

max_size_group = 2

load_balancers = "web_app_load_balancer"

force_delete = true

propagate_at_launch = true

