#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/target-group/variables.tf
#description     :default variables for the target group
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------------#
variable "CATEGORY" {
    description = "Category used for deployment"
    type        =  string
}

variable "PORT" {
    description = "Target group port listener"
    type        =  number
}

variable "PROTOCOL" {
    description = "protocol to be used for the target group"
    type        =  string
}

variable "VPC_ID" {
    description = "vpc in which the target group should be created"
    type        =  string
}

variable "SLOW_START" {
    description = "time to wait before sending traffic"
    type        =  number
}

variable "INTERVAL" {
}

variable "ENVIRONMENT" {
}
variable "PROJECT_NAME" {
}

variable "STICKINESS_TYPE" {
}
variable "COOKIE_DURATION" {
}
variable "STICKINESS_ENABLED" {
}
variable "HEALTHY_THRESHOLD" {
}
variable "UNHEALTHY_THRESHOLD" {
}
variable "MATCHER" {
}
variable "PATH" {
}
variable "HEALTH_CHECK_PORT" {
}
variable "HEALTH_CHECK_PROTOCOL" {
}
variable "TIMEOUT" {
}
#------------------------------------------------------------------------------------------------------------------#


#subnet tags
#--------------------------------------------------------------------------------------------------------------------#
variable "TG_TAGS" {
    description = "SUBNET related tags"
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
