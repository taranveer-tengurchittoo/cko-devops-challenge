#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/internet_gateway/main.tf
#description     :terraform module to attach internet gateway to vpc
#author          :Taranveer TENGURCHITTOO (taranveer.tengurchittoo@checkout.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_vpc
#https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_internet_gateway" "internet_gateway_template" {
    vpc_id                                  = var.VPC_ID
    tags                                    = merge(var.IG_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#
