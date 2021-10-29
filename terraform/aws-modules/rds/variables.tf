#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/rds/variables.tf
#description     :default variable values
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#rds values
#--------------------------------------------------------------------------------------------------------------------#
variable "BACKUP_RETENTION_PERIOD" {
    description = "The backup retention for the database snapshots"
    type        = number
    default     = 14
}
variable "ENGINE" {
    description = "Engine for the database"
    type        = string
    default     = "aurora"
}
variable "ENGINE_MODE" {
    description = "Engine mode for the database"
    type        = string
    default     = "serverless"
}
variable "MASTER_USERNAME" {
    description = "Administrator username"
    type        = string
}
variable "MASTER_PASSWORD" {
    description = "Initial database password"
    type        = string
}
variable "PREFERRED_BACKUP_WINDOW" {
    description = "Backup windows for maintenance"
    type        = string
}
variable "DB_PORT" {
    description = "Customized DB port"
    type        = number
    default     = 7706
}
variable "DB_SUBNET_IDS" {
    description = "DB Subnet groups"
    type        = list
}
variable "AUTO_PAUSE" {
    description = "Whether to shut down the database if there are no connections"
    type        = string
    default     = true
}
variable "MAX_CAPACITY" {
    description = "Maximum number of vCPUs"
    type        = number
    default     = 16
}
variable "MIN_CAPACITY" {
    description = "Minimum number of vCPUs"
    type        = number
    default     = 2
}
variable "KMS_KEY_ARN" {
    description = "Key used to encrypt the database"
}
variable "SECONDS_UNTIL_AUTO_PAUSE" {
    description = "Wait time before shutting down the database"
    type        = number
    default     = 300
}

variable "SKIP_FINAL_SNAPSHOT" {
    description = "Whether or not to perform a final snapshot before deleting the cluster"
    type        = string
    default     = "false"
}
variable "SECURITY_GROUP_ID" {
    description = "Security group to attach to the RDS"
    type        = string
}

#------------------------------------------------------------------------------------------------------------------#

#aws region tag
#--------------------------------------------------------------------------------------------------------------------#
variable "AWS_REGION" {
    description = "aws region"
    type        =  string
}
#------------------------------------------------------------------------------------------------------------------#


#rds tags
#--------------------------------------------------------------------------------------------------------------------#
variable "DB_TAGS" {
    description = "DB related tags"
    type        =  map
}
#------------------------------------------------------------------------------------------------------------------#

#project wide tags
#--------------------------------------------------------------------------------------------------------------------#
variable "PROJECT_WIDE_TAGS" {
    description = "Tags to be associated with all resources in the project"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#

#interpolate resource names #non-dry
#--------------------------------------------------------------------------------------------------------------------#
variable "PROJECT_NAME" {
    description = "Project name that will be used to generate resource names"
    type        = string
    default     = "cko-dc"  
}
variable "ENVIRONMENT" {
    description = "Environment that will be used to generate resource names"
    type        = string
    default     = "dev"  
}