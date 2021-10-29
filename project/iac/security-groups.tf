#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/security-groups.tf
#description     : security group configuration via terraform
#author          : Taranveer TENGURCHITTOO (taranveer.tengurchittoo@checkout.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

# Security Groups
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-app-sg" {
    source                                    = "../../terraform/aws-modules/security-group"
    #security group parameters
    EGRESS_RULES                              = [
        ["Allow outbound access towards RDS", ["${var.CIDR_BLOCK}.1.0/24"], "3306", "3306", "tcp"],
        ["Allow outbound access towards Internet", ["0.0.0.0/0"], "443", "443", "tcp"]
    ]
    INGRESS_RULES                             = [
        ["Allow SSH from administration network", ["${var.CIDR_BLOCK}.0.0/24"], "22", "22", "tcp"],
        ["Allow HTTP access from ELBs", ["${var.CIDR_BLOCK}.3.0/24"], "80", "80", "tcp"],
    ]
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    #tags
    SECURITY_GROUP_TAGS                       = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-web-sg"
        type                                  = "security-group"
    }
    PROJECT_WIDE_TAGS                         = var.PROJECT_WIDE_TAGS
}

module "cko-devops-challenge-db-sg" {
    source                                    = "../../terraform/aws-modules/security-group"
    #security group parameters
    EGRESS_RULES                              = [
        #["Allow outbound access towards RDS", ["${var.CIDR_BLOCK}.1.0/16"], "3306", "3306", "tcp"]
    ]
    INGRESS_RULES                             = [
        ["Allow access from application subnets", ["${var.CIDR_BLOCK}.2.0/24"], "3306", "3306", "tcp"],
    ]
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    #tags
    PROJECT_WIDE_TAGS                         = var.PROJECT_WIDE_TAGS
    SECURITY_GROUP_TAGS                       = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-db-sg"
        type                                  = "security-group"
    }
}

module "cko-devops-challenge-web-sg" {
    source                                    = "../../terraform/aws-modules/security-group"
    #security group parameters
    EGRESS_RULES                              = [
        ["Allow access from application subnets", ["${var.CIDR_BLOCK}.2.0/24"], "80", "80", "tcp"],
    ]
    INGRESS_RULES                             = [
        ["Allow access from web / tester", ["${var.MY_IP}/32"], "80", "80", "tcp"],
    ]

    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    #tags
    SECURITY_GROUP_TAGS                       = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-db-sg"
        type                                  = "security-group"
    }
    PROJECT_WIDE_TAGS                         = var.PROJECT_WIDE_TAGS
}
#--------------------------------------------------------------------------------------------------------------------#
