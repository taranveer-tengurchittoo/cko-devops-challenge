#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/autoscaling_group/main.tf
#description     :terraform module to create autoscaling group
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_vpc
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_autoscaling_group" "autoscaling_group_template" {
  name_prefix               = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-asg"
  max_size                  = var.MAX_SIZE
  min_size                  = var.MIN_SIZE
  health_check_grace_period = var.HEALTH_CHECK_GRACE_PERIOD
  health_check_type         = "ELB"
  default_cooldown          = var.DEFAULT_COOLDOWN
  desired_capacity          = var.DESIRED_CAPACITY
  force_delete              = true
  launch_template {
    id      = var.LAUNCH_TEMPLATE
    version = "$Latest"
  }
  vpc_zone_identifier       = ["${var.SUBNET_1}", "${var.SUBNET_2}", "${var.SUBNET_3}"]
  tags                      = var.ASG_TAGS

  lifecycle {
    create_before_destroy = true
    ignore_changes = [load_balancers, target_group_arns]
  }
  timeouts {
    delete = "5m"
  }
}

resource "aws_autoscaling_policy" "agents-scale-up" {
    name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.CATEGORY}-agents-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 30
    autoscaling_group_name = aws_autoscaling_group.autoscaling_group_template.name
}

resource "aws_autoscaling_policy" "agents-scale-down" {
    name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.CATEGORY}-agents-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 30
    autoscaling_group_name = aws_autoscaling_group.autoscaling_group_template.name
}

resource "aws_cloudwatch_metric_alarm" "cpu-high" {
    alarm_name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.CATEGORY}-cpu-util-high-agents"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "70"
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.agents-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.autoscaling_group_template.name
    }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
    alarm_name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.CATEGORY}-cpu-util-low-agents"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "40"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.agents-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.autoscaling_group_template.name
    }
}
#--------------------------------------------------------------------------------------------------------------------#
