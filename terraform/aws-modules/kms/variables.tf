#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/kms/variables.tf
#description     :terraform file containing the variables for the kms module
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#kms
variable "CUSTOMER_MASTER_KEY_SPEC" {
    default = "RSA_4096" 
    type    = string
}

variable "ENABLE_KEY_ROTATION" {
    default = "true"
    type    = string
}

variable "KMS_IS_ENABLED" {
    default = "true"
    type    = string
}

variable "KEY_USAGE" {
    default = "ENCRYPT_DECRYPT"
    type    = string
}

variable "KMS_POLICY" {
}
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

variable "PROJECT_WIDE_TAGS" {
    description = "Tags containing the project details"
    type        = map
}

variable "KMS_TAGS" {
    description = "Tags that will be assigned to the security group"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#
