#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/rds/main.tf
#description     :aws module to deploy rds
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_rds
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_db_subnet_group" "db_subnet_group_template" {
    name                                    = "${var.PROJECT_NAME}-${var.ENVIRONMENT}"
    subnet_ids                              = var.DB_SUBNET_IDS
    tags                                    = merge(var.DB_TAGS, var.PROJECT_WIDE_TAGS)
}
resource "aws_rds_cluster" "rds_template" {
    allow_major_version_upgrade             = "false"
    apply_immediately                       = "false"
    availability_zones                      = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
    backup_retention_period                 = var.BACKUP_RETENTION_PERIOD
    copy_tags_to_snapshot                   = "true"
    #database_name                           = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-rds"
    cluster_identifier                      = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-rds"
    db_subnet_group_name                    = aws_db_subnet_group.db_subnet_group_template.id
    #enabled_cloudwatch_logs_exports         = ["audit", "error", "general", "slowquery"] #works only for PostGreSQL
    engine                                  = var.ENGINE
    engine_mode                             = var.ENGINE_MODE
    kms_key_id                              = var.KMS_KEY_ARN
    master_password                         = var.MASTER_PASSWORD
    master_username                         = var.MASTER_USERNAME
    #port                                    = var.DB_PORT # aurora does not support custom port
    preferred_backup_window                 = var.PREFERRED_BACKUP_WINDOW
    skip_final_snapshot                     = var.SKIP_FINAL_SNAPSHOT
    scaling_configuration {
        auto_pause                          = var.AUTO_PAUSE
        max_capacity                        = var.MAX_CAPACITY
        min_capacity                        = var.MIN_CAPACITY
        seconds_until_auto_pause            = var.SECONDS_UNTIL_AUTO_PAUSE
        timeout_action                      = "ForceApplyCapacityChange"
    }
    tags                                    = merge(var.DB_TAGS, var.PROJECT_WIDE_TAGS)
    vpc_security_group_ids                  = ["${var.SECURITY_GROUP_ID}"]
}
#--------------------------------------------------------------------------------------------------------------------#
