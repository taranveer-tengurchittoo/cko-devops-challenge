#--------------------------------------------------------------------------------------------------------------------#
#title           :iac/variables.tf
#description     :default variable values
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#provider
#--------------------------------------------------------------------------------------------------------------------#
variable "AWS_REGION" {
    description = "Region in which the resources will be deployed"
    type        = string
    default     = "ap-southeast-1"
}
variable "AWS_PROFILE" {
    description = "Profile that will be used to deploy the resources"
    type        = string
    default     = "cko-playground"   
}
variable "CREDENTIALS_FILE" {
    description = "Credentials file to use for the provider"
    type        = string
    default     = "~/.aws/config"  
}
#--------------------------------------------------------------------------------------------------------------------#

#vpc variables
#--------------------------------------------------------------------------------------------------------------------#
variable "CIDR_BLOCK" {
    description = "First 2 octets for the VPC CIDR"
    type        = string
}
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#

#project wide tags
#--------------------------------------------------------------------------------------------------------------------#
variable "PROJECT_WIDE_TAGS" {
    description = "Tags to be associated with all resources in the project"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#

#public IP
#--------------------------------------------------------------------------------------------------------------------#
variable "MY_IP" {
    description = "Public IP whitelisted in the web security group"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#

#interpolate resource names #non-dry
#--------------------------------------------------------------------------------------------------------------------#
variable "PROJECT_NAME" {
    description = "Project name that will be used to generate resource names"
    type        = string
    default     = "cko-devops-challenge"  
}
variable "ENVIRONMENT" {
    description = "Environment that will be used to generate resource names"
    type        = string
    default     = "development"  
}

variable "KEY_TAGS" {
    description = "Tags for the ssh key pair"
    type        = map
}
variable "ASG_TAGS" {
    description = "Tags for ASGs"
}
#--------------------------------------------------------------------------------------------------------------------#
