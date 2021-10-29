#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/subnet.tf
#description     : subnet configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#database subnets
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-database-subnet-a" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}a"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.1.0/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id
    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-db-subnet-a"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-database-subnet-b" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}b"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.1.16/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    #tags
    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-db-subnet-b"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-database-subnet-c" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}c"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.1.32/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    #tags
    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-db-subnet-c"
        type                                  = "subnet"
    }
}

#--------------------------------------------------------------------------------------------------------------------#

#application subnets
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-app-subnet-a" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}a"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.2.0/27"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-app-subnet-a"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-app-subnet-b" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}b"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.2.32/27"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-app-subnet-b"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-app-subnet-c" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}c"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.2.64/27"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-app-subnet-c"
        type                                  = "subnet"
    }
}
#--------------------------------------------------------------------------------------------------------------------#

#web subnets
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-web-subnet-a" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}a"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.3.0/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-web-subnet-a"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-web-subnet-b" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}b"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.3.16/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-web-subnet-b"
        type                                  = "subnet"
    }
}
module "cko-devops-challenge-web-subnet-c" {
    #subnet parameters
    source                                    = "../../terraform/aws-modules/subnet"
    AVAILABILITY_ZONE                         = "${var.AWS_REGION}c"
    SUBNET_CIDR                               = "${var.CIDR_BLOCK}.3.32/28"
    VPC_ID                                    = module.cko-devops-challenge-vpc.vpc-id

    PROJECT_WIDE_TAGS 						  = var.PROJECT_WIDE_TAGS
    SUBNET_TAGS                               = {
        Name                                  = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-web-subnet-c"
        type                                  = "subnet"
    }
}
#--------------------------------------------------------------------------------------------------------------------#