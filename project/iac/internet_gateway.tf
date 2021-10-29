#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/internet_gateway.tf
#description     : internet gateway configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-28
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#internet gateway
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-internet-gateway" {
    #internet gateway parameters
    source                              = "../../terraform/aws-modules/internet-gateway"
    VPC_ID                              = module.cko-devops-challenge-vpc.vpc-id

    #tags
    IG_TAGS                             = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ig"
        type = "internet-gateway"
    }
    PROJECT_WIDE_TAGS                   = var.PROJECT_WIDE_TAGS
}
#--------------------------------------------------------------------------------------------------------------------#
