resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "aws_autoscaling_group" "meine_asg" {
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = aws_subnet.main_subnet[*].id

  target_group_arns = [aws_lb_target_group.web_target_group.arn]

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Webshop_AutoscalingGroup-${terraform.workspace}-${random_string.suffix.id}"
    propagate_at_launch = true
  }

  health_check_type           = "EC2"
  health_check_grace_period   = 300
  default_cooldown            = 300
  termination_policies        = ["Default"]

  metrics_granularity = "1Minute"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up_policy"
  scaling_adjustment     = 1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.meine_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down_policy"
  scaling_adjustment     = -1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.meine_asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.meine_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low_cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.meine_asg.name
  }
}
