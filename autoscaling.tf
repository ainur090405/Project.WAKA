resource "aws_launch_template" "latihan_launch_template_pkm" {
  name_prefix   = "latihan-launch-template-pkm"
  image_id      = local.loc_ami
  instance_type = local.loc_instance
  key_name      = aws_key_pair.latihanKeyPairPKM.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.latihan-security-group-PKM.id]
  }

  user_data = base64encode(data.template_file.user_data_pkm.rendered)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Latihan-ec2PKM-AutoScaling"
    }
  }
}

resource "aws_autoscaling_group" "latihan_autoscaling_group_pkm" {
  name                = "latihan-autoscaling-group-pkm"
  vpc_zone_identifier = [aws_subnet.latihan_subnet_public_pkm.id, aws_subnet.latihan_subnet_public2_pkm.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  target_group_arns = [aws_lb_target_group.latihan_tg.arn]

  launch_template {
    id      = aws_launch_template.latihan_launch_template_pkm.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Latihan-ec2PKM-ASG"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "latihan_auto_policy_pkm" {
  name                   = "latihan-auto-policy-pkm"
  autoscaling_group_name = aws_autoscaling_group.latihan_autoscaling_group_pkm.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}
