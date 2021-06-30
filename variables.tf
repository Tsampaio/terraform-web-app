variable "vpc_cidr_block" {}

variable "public_subnet" {}

variable "private_subnet" {}

variable "ec2_keypair" {}

variable "ec2_instance_type" {}

variable "ssh_allowed_ip" {}

variable "region" {}

variable "env_code" {}

variable "force_delete" {}

variable autoscaling_group_name {}

variable load_balancers {}

variable max_size_group {}

variable min_size_group {}

variable health_check_grace_period {}

variable health_check_type {}

variable desired_capacity {}