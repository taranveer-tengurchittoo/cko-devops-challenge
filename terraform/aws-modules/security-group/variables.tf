#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/security-group/variables.tf
#description     :terraform variable file for security groups
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#security_groups
variable "VPC_ID" {
    description = "The VPC in which the security group will be created"
    type        = string

}

variable "EGRESS_RULES" {
    description = "Outbound rules for the security group"
    type        = list

}

# variable "INSTANCE_GROUP" {
#   description = "Name of the instances for which the security group has been created"
#   type        = string
# }

variable "INGRESS_RULES" {
    description = "Inbound rules for the security group"
    type        = list
}

# variable "SECURITY_GROUP_NAME" {
#   description = "Name of the security group"
#   type        = string
# }
#--------------------------------------------------------------------------------------------------------------------#

#--------------------------------------------------------------------------------------------------------------------#
#tags
variable "PROJECT_WIDE_TAGS" {
    description = "Tags to be associated with all resources in the project"
    type        = map
}

variable "SECURITY_GROUP_TAGS" {
    description = "Tags that will be assigned to the security group"
    type        = map
}
#--------------------------------------------------------------------------------------------------------------------#
