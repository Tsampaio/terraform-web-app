resource "aws_placement_group" "placement_group" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = var.autoscaling_group_name
  load_balancers            = var.load_balancers
  max_size                  = var.max_size_group
  min_size                  = var.min_size_group
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  placement_group           = aws_placement_group.placement_group.id
  # launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier = [var.subnet_id]

  # initial_lifecycle_hook {
  #   name                 = "foobar"
  #   default_result       = "CONTINUE"
  #   heartbeat_timeout    = 2000
  #   lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  # notification_metadata = <<EOF
  #       {
  #         "foo": "bar"
  #       }
  #       EOF

  # notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
  # role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  # }

  tag {
    Name = var.autoscaling_group_name
  }
}
