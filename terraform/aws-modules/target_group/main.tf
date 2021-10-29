#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/target-group/main.tf
#description     :terraform module to target group to attach to ELB
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_vpc
#https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_lb_target_group" "target_group_template" {
  name     = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.CATEGORY}-tg"
  port     = var.PORT
  protocol = var.PROTOCOL
  vpc_id   = var.VPC_ID
  slow_start = var.SLOW_START
  stickiness {
    type            = var.STICKINESS_TYPE
    cookie_duration = var.COOKIE_DURATION
    enabled         = var.STICKINESS_ENABLED
  }
  health_check {
        healthy_threshold   = var.HEALTHY_THRESHOLD
        unhealthy_threshold = var.UNHEALTHY_THRESHOLD
        interval            = var.INTERVAL
        matcher             = var.MATCHER
        path                = var.PATH
        port                = var.HEALTH_CHECK_PORT
        protocol            = var.HEALTH_CHECK_PROTOCOL
        timeout             = var.TIMEOUT
  }
  tags                      = merge(var.TG_TAGS, var.PROJECT_WIDE_TAGS)
}

#--------------------------------------------------------------------------------------------------------------------#
