#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/subnet/variables.tf
#description     :default variable values
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#subnet values
#--------------------------------------------------------------------------------------------------------------------#
variable "SUBNET_CIDR" {
    description = "Full subnet CIDR"
    type        = string
}
variable "AVAILABILITY_ZONE" {
    description = "Availability zone in which the subnet should be created"
    type        = string
}
variable "MAP_PUBLIC_IP_ON_LAUNCH" {
    description = "Whether or not to create a public subnet"
    type        = string
    default     = "false"
}
variable "VPC_ID" {
    description = "VPC in which the subnet should be created"
    type        = string
}
#------------------------------------------------------------------------------------------------------------------#

#subnet tags
#--------------------------------------------------------------------------------------------------------------------#
variable "SUBNET_TAGS" {
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
