resource "aws_security_group" "ec2-security-group" {
  name   = var.autoscaling_group_name
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
