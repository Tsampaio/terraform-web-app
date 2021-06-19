vpc_cidr_block = "10.0.0.0/16"
public_subnet = {
  cidr = ["10.0.1.0/24", "10.0.2.0/24"]
}
private_subnet = {
  cidr = ["10.0.3.0/24", "10.0.4.0/24"]
}

eip_association_address = "10.0.1.0/24"
ec2_keypair             = "my-first-ec2-instance"
ec2_instance_type       = "t2.micro"
