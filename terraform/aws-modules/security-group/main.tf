#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/security-group/main.tf
#description     :terraform module to deploy security group
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_security_group
#https://www.terraform.io/docs/providers/aws/r/security_group.html
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_security_group" "template" {
    #name        				            = var.SECURITY_GROUP_NAME
    #description 				            = "Security group for ${var.INSTANCE_GROUP}"
    vpc_id      				            = var.VPC_ID
    tags                                    = merge(var.SECURITY_GROUP_TAGS, var.PROJECT_WIDE_TAGS)
}

resource "aws_security_group_rule" "ingress_rules" {
    count                                   = length(var.INGRESS_RULES) 
    security_group_id                       = aws_security_group.template.id
    type                                    = "ingress"
    description                             = var.INGRESS_RULES[count.index][0]
    cidr_blocks                             = var.INGRESS_RULES[count.index][1]
    from_port                               = var.INGRESS_RULES[count.index][2]
    to_port                                 = var.INGRESS_RULES[count.index][3]
    protocol                                = var.INGRESS_RULES[count.index][4]
}

resource "aws_security_group_rule" "egress_rules" {
    count                                   = length(var.EGRESS_RULES) 
    security_group_id                       = aws_security_group.template.id
    type                                    = "egress"
    description                             = var.EGRESS_RULES[count.index][0]
    cidr_blocks                             = var.EGRESS_RULES[count.index][1]
    from_port                               = var.EGRESS_RULES[count.index][2]
    to_port                                 = var.EGRESS_RULES[count.index][3]
    protocol                                = var.EGRESS_RULES[count.index][4]
}
#--------------------------------------------------------------------------------------------------------------------#
