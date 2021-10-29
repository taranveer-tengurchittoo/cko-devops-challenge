#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/nat-gateway/main.tf
#description     :terraform module to deploy security group
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_security_group
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_nat_gateway" "nat-gateway-template" {
  allocation_id     = var.ALLOCATION_ID
  connectivity_type = "public"
  subnet_id         = var.SUBNET_ID
  tags              = merge(var.NG_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#
