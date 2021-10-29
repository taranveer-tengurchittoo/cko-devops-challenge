#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/lanch-template/variables.tf
#description     :default variable values
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#ec2
variable "ASSOCIATE_PUBLIC_IP_ADDRESS" {
    description = "Whether or not to assign a public address"
    type        = string
    default     = "false"
}
variable "DELETE_ON_TERMINATION" {
    description = "Whether or not to assign a public address"
    type        = string
    default     = "true" # will increase costs if set to false as we will have dangling volumes
}
variable "DISABLE_API_TERMINATION" {
    description = "Whether or not to allow termination"
    type        = string
    default     = "false" # cant' destroy if it's set to false
}
variable "INSTANCE_TYPE" {
    description = "Which instance type to use for the project"
    type        = string
}
variable "KEY_NAME" {
    description = "SSH Key pair to use"
    type        = string
}
variable "ENCRYPTED" {
    description = "Encryption for data at rest"
    type        = string
    default     = "true"
}
variable "KMS_KEY_ARN" {
    description = "KMS ARN to be used"
    type        = string
}
variable "MONITORING" {
    description = "Whether enhanced monitoring should be used"
    type        = string
}
variable "IAM_INSTANCE_PROFILE" {
    description = "IAM instance profile to use"
    type        = string
}
variable "ROOT_VOLUME_SIZE" {
    description = "Root volume size"
    type        = number
}
variable "SECURITY_GROUP" {}
variable "VOLUME_TYPE" {
    description = "KMS ARN to be used"
    type        = string
    default     = "gp3"
}
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
variable "PROJECT_NAME" {
    description = "Tags containing the project details"
    type        = string
}

variable "ENVIRONMENT" {
    description = "Tags containing the project details"
    type        = string
}

variable "PROJECT_WIDE_TAGS" {
    description = "Tags containing the project details"
    type        = map
}

variable "INSTANCE_TAGS" {
    description = "Tags that will be assigned to the security group"
    type        = map
}
variable "VOLUME_TAGS" {
    description = "Tags that will be assigned to the security group"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#
