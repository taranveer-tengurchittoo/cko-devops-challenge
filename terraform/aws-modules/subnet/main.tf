#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/subnet/main.tf
#description     :aws module to deploy subnet
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_subnet
#https://www.terraform.io/docs/providers/aws/r/subnet.html
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_subnet" "subnet_template" {
    vpc_id                                  = var.VPC_ID
    availability_zone                       = var.AVAILABILITY_ZONE
    cidr_block                              = var.SUBNET_CIDR
    map_public_ip_on_launch                 = var.MAP_PUBLIC_IP_ON_LAUNCH
    tags                                    = merge(var.SUBNET_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#
