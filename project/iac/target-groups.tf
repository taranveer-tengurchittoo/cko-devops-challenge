#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/target-groups.tf
#description     : target-group configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#kms
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-app-tg-blue" {
    #target group parameters
    source                      = "../../terraform/aws-modules/target_group"
    HEALTHY_THRESHOLD           =  "3"
    HEALTH_CHECK_PORT           =  "traffic-port"
    HEALTH_CHECK_PROTOCOL       =  "HTTP"
    PATH                        =  "/"
    STICKINESS_TYPE             =  "lb_cookie"
    TIMEOUT                     =  "3"
    UNHEALTHY_THRESHOLD         =  "2"
    INTERVAL                    =  "5"
    MATCHER                     =  "200,302"
    CATEGORY                    =  "blue"
    COOKIE_DURATION             =  "86400"
    PORT                        =  "80"
    PROTOCOL                    =  "HTTP"
    SLOW_START                  =  "30"
    STICKINESS_ENABLED          =  "true"
    VPC_ID                      =  module.cko-devops-challenge-vpc.vpc-id

    #tags
    ENVIRONMENT                 = var.ENVIRONMENT
    PROJECT_NAME                = var.PROJECT_NAME
    PROJECT_WIDE_TAGS                = var.PROJECT_WIDE_TAGS
    TG_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-tg"
        type = "target-group"
    }
}

module "cko-devops-challenge-app-tg-green" {
    #target group parameters
    source                      = "../../terraform/aws-modules/target_group"
    HEALTHY_THRESHOLD           =  "3"
    HEALTH_CHECK_PORT           =  "traffic-port"
    HEALTH_CHECK_PROTOCOL       =  "HTTP"
    PATH                        =  "/"
    STICKINESS_TYPE             =  "lb_cookie"
    TIMEOUT                     =  "3"
    UNHEALTHY_THRESHOLD         =  "2"
    INTERVAL                    =  "5"
    MATCHER                     =  "200,302"
    CATEGORY                    =  "green"
    COOKIE_DURATION             =  "86400"
    PORT                        =  "80"
    PROTOCOL                    =  "HTTP"
    SLOW_START                  =  "180"
    STICKINESS_ENABLED          =  "true"
    VPC_ID                      =  module.cko-devops-challenge-vpc.vpc-id

    #tags
    ENVIRONMENT                 = var.ENVIRONMENT
    PROJECT_NAME                = var.PROJECT_NAME
    PROJECT_WIDE_TAGS                = var.PROJECT_WIDE_TAGS
    TG_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-tg"
        type = "target-group"
    }
}
#--------------------------------------------------------------------------------------------------------------------#
