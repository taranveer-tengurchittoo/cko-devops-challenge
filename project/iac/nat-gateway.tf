#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/nat-gateway.tf
#description     : terraform nat-gateway configuration file
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#kms
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-ng-a" {
    source                          = "../../terraform/aws-modules/nat-gateway"
    ALLOCATION_ID                   = aws_eip.cko-devops-challenge-eip-a.id
    SUBNET_ID                       = module.cko-devops-challenge-web-subnet-a.subnet-id    
    PROJECT_WIDE_TAGS               = var.PROJECT_WIDE_TAGS
    NG_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ng-a"
        type = "nat-gateway"
    }
}
module "cko-devops-challenge-ng-b" {
    source                          = "../../terraform/aws-modules/nat-gateway"
    ALLOCATION_ID                   = aws_eip.cko-devops-challenge-eip-b.id
    SUBNET_ID                       = module.cko-devops-challenge-web-subnet-b.subnet-id 
    PROJECT_WIDE_TAGS               = var.PROJECT_WIDE_TAGS         
    NG_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ng-b"
        type = "nat-gateway"
    }
}
module "cko-devops-challenge-ng-c" {
    source                          = "../../terraform/aws-modules/nat-gateway"
    ALLOCATION_ID                   = aws_eip.cko-devops-challenge-eip-c.id
    SUBNET_ID                       = module.cko-devops-challenge-web-subnet-c.subnet-id    
    PROJECT_WIDE_TAGS               = var.PROJECT_WIDE_TAGS      
    NG_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ng-c"
        type = "nat-gateway"
    }
}
#--------------------------------------------------------------------------------------------------------------------#
