#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/vpc/main.tf
#description     :aws module to deploy vpc
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_vpc
#https://www.terraform.io/docs/providers/aws/r/vpc.html
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_vpc" "vpc_template" {
    cidr_block                              = var.CIDR_BLOCK
    enable_dns_hostnames                    = "true"
    enable_dns_support                      = "true"
    assign_generated_ipv6_cidr_block        = "false"
    tags                                    = merge(var.VPC_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#
