#--------------------------------------------------------------------------------------------------------------------#
#title           :compute/variables.tf
#description     :default variable values
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#ec2
variable "MIN_SIZE" {}
variable "MAX_SIZE" {}
variable "HEALTH_CHECK_GRACE_PERIOD" {}
variable "DESIRED_CAPACITY" {}
variable "DEFAULT_COOLDOWN" {}
variable "LAUNCH_TEMPLATE" {}
variable "SUBNET_1" {}
variable "SUBNET_2" {}
variable "SUBNET_3" {}
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#tags
variable "PROJECT_NAME" {
    description = "Tags containing the project details"
    type        = string
}

variable "ENVIRONMENT" {
    description = "Tags containing the project details"
    type        = string
}

variable "CATEGORY" {
    description = "Category of the deployment"
    type        = string
}

variable "ASG_TAGS" {
    description = "Tags that will be assigned to the security group"
}
#--------------------------------------------------------------------------------------------------------------------#
