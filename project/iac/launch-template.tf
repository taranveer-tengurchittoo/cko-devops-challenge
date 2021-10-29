#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/launch-template.tf
#description     : launch template configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-28
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#launch template
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-launch_template" {
    #launch template parameters
    source                                      = "../../terraform/aws-modules/launch-template"
    ASSOCIATE_PUBLIC_IP_ADDRESS                 = "false"
    DELETE_ON_TERMINATION                       = "true"
    ENCRYPTED                                   = "true"
    IAM_INSTANCE_PROFILE                        = aws_iam_instance_profile.ec2-instance-profile.name
    INSTANCE_TYPE                               = "c5.large"
    KEY_NAME                                    = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-key-pair"
    KMS_KEY_ARN                                     = module.cko-devops-challenge-kms.key-arn
    MONITORING                                  = "true"
    ROOT_VOLUME_SIZE                            = 14
    SECURITY_GROUP                              = module.cko-devops-challenge-app-sg.sg-id
    VOLUME_TYPE                                 = "gp3"

    #tags
    ENVIRONMENT                                 = var.ENVIRONMENT
    PROJECT_NAME                                = var.PROJECT_NAME
    PROJECT_WIDE_TAGS                           = var.PROJECT_WIDE_TAGS

    INSTANCE_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-lt-instance"
        type = "ec2-instance"
    }
    VOLUME_TAGS                                  = {
        Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-lt-instance"
        type = "ebs-volume"
    }
}
#--------------------------------------------------------------------------------------------------------------------#
