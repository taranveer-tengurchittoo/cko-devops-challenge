#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/nat-gateway/variables.tf
#description     :terraform variable file for security groups
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#nat-gateaway 
variable "SUBNET_ID" {
    description = "The subnet for which the nat gateway is being created"
    type        = string

}
variable "ALLOCATION_ID" {
    description = "The EIP which will be attached to the NAT Gateway"
    type        = string

}
#--------------------------------------------------------------------------------------------------------------------#
#tags
variable "PROJECT_WIDE_TAGS" {
    description = "Tags to be associated with all resources in the project"
    type        = map
}

variable "NG_TAGS" {
    description = "Tags that will be assigned to the security group"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#
