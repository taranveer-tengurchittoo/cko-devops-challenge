#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/autoscaling.tf
#description     : autoscaling configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#autoscaling
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-app-asg-blue" {

    #asg parameters
    source                      = "../../terraform/aws-modules/autoscaling"
    CATEGORY                    = "blue"
    DEFAULT_COOLDOWN            = 120
    DESIRED_CAPACITY            = 2
    ENVIRONMENT                 = var.ENVIRONMENT
    HEALTH_CHECK_GRACE_PERIOD   = 240
    LAUNCH_TEMPLATE             = module.cko-devops-challenge-launch_template.launch_template_id
    MAX_SIZE                    = 5
    MIN_SIZE                    = 2
    PROJECT_NAME                = var.PROJECT_NAME
    SUBNET_1                    = module.cko-devops-challenge-app-subnet-a.subnet-id
    SUBNET_2                    = module.cko-devops-challenge-app-subnet-b.subnet-id
    SUBNET_3                    = module.cko-devops-challenge-app-subnet-c.subnet-id
    
    #tags
    ASG_TAGS = concat(
      [ {
        key                     = "category"
        value                   = "blue"
        propagate_at_launch     = true
      },
      ],  
      var.ASG_TAGS,
    )

    #wait for rds 
    depends_on = [module.cko-devops-challenge-rds.rds-id]
}

module "cko-devops-challenge-app-asg-green" {

  #asg parameters
  source                      = "../../terraform/aws-modules/autoscaling"
  CATEGORY                    = "green"
  DEFAULT_COOLDOWN            = 120
  DESIRED_CAPACITY            = 2
  ENVIRONMENT                 = var.ENVIRONMENT
  HEALTH_CHECK_GRACE_PERIOD   = 240
  LAUNCH_TEMPLATE             = module.cko-devops-challenge-launch_template.launch_template_id
  MAX_SIZE                    = 5
  MIN_SIZE                    = 2
  PROJECT_NAME                = var.PROJECT_NAME
  SUBNET_1                    = module.cko-devops-challenge-app-subnet-a.subnet-id
  SUBNET_2                    = module.cko-devops-challenge-app-subnet-b.subnet-id
  SUBNET_3                    = module.cko-devops-challenge-app-subnet-c.subnet-id

  #tags
  ASG_TAGS = concat(
    [ {
      key                     = "category"
      value                   = "green"
      propagate_at_launch     = true
    },
    ],  
    var.ASG_TAGS,
  )

  #wait for rds
  depends_on = [module.cko-devops-challenge-app-asg-blue.asg-id]
}

#target group attachment
#--------------------------------------------------------------------------------------------------------------------#
#blue asg target group attachment
resource "aws_autoscaling_attachment" "cko-devops-challenge-app-blue" {
  alb_target_group_arn   = module.cko-devops-challenge-app-tg-blue.tg-id
  autoscaling_group_name = module.cko-devops-challenge-app-asg-blue.asg-id
}
#green asg target group attachment
resource "aws_autoscaling_attachment" "cko-devops-challenge-app-green" {
  alb_target_group_arn = module.cko-devops-challenge-app-tg-green.tg-id
  autoscaling_group_name = module.cko-devops-challenge-app-asg-green.asg-id
}
#--------------------------------------------------------------------------------------------------------------------#