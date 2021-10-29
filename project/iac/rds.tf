#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/rds.tf
#description     : rds configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#rds
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-rds" {
  #rds parameters
  source                    = "../../terraform/aws-modules/rds"
  #DB_PORT                   = 7706 # Aurora does not support custom port
  AWS_REGION                = var.AWS_REGION
  BACKUP_RETENTION_PERIOD   = 14
  DB_SUBNET_IDS             = [module.cko-devops-challenge-database-subnet-a.subnet-id, module.cko-devops-challenge-database-subnet-b.subnet-id, module.cko-devops-challenge-database-subnet-c.subnet-id]
  ENGINE                    = "aurora-mysql"
  ENGINE_MODE               = "serverless"
  KMS_KEY_ARN               = module.cko-devops-challenge-kms.key-arn
  MASTER_PASSWORD           = "65Fm#&P3#qv37ObDJf"
  MASTER_USERNAME           = "ckc_dc_admin"
  PREFERRED_BACKUP_WINDOW   = "04:00-05:00"
  SECURITY_GROUP_ID         = module.cko-devops-challenge-db-sg.sg-id
  SKIP_FINAL_SNAPSHOT       = "true" # to allow for quicker destroy for the test

  #autoscaling
  AUTO_PAUSE                = "true"
  MAX_CAPACITY              = 16
  MIN_CAPACITY              = 2
  SECONDS_UNTIL_AUTO_PAUSE  = 300
  PROJECT_WIDE_TAGS         = var.PROJECT_WIDE_TAGS

  #tags
  DB_TAGS = {
    Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-rds"
    type = "rds"
  }
}
#--------------------------------------------------------------------------------------------------------------------#
