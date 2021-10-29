#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/vpc.tf
#description     : vpc configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#vpcs
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-vpc" {
    #vpc parameters
    source                                    = "../../terraform/aws-modules/vpc"
    CIDR_BLOCK                                = "${var.CIDR_BLOCK}.0.0/16"

    #tags
    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    VPC_TAGS                                  = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}"
        type                                  = "vpc"
    }
}
#--------------------------------------------------------------------------------------------------------------------#
