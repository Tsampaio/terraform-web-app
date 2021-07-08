variable "vpc_cidr_block" {}

variable "public_subnet" {}

variable "private_subnet" {}

variable "ec2_keypair" {}

variable "ec2_instance_type" {}

variable "ssh_allowed_ip" {}

variable "region" {}

variable "env_code" {}

variable "autoscaling_group_name" {}

variable "auto_scale_group_instance" {}

variable "max_size_group" {}

variable "min_size_group" {}

variable "load_balancers" {}

variable "force_delete" {}

variable "propagate_at_launch" {}
