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

load_balancers = "web_app_load_balancer"

health_check_grace_period = 300

health_check_type = "ELB"

desired_capacity = 2

force_delete = true

