#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/kms/main.tf
#description     :terraform module to create kms key
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#kms_key
#https://www.terraform.io/docs/providers/aws/d/kms_key.html
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_kms_key" "template_key" {
  description                           = "${var.PROJECT_NAME} kms encryption key"
  customer_master_key_spec              = var.CUSTOMER_MASTER_KEY_SPEC
  enable_key_rotation                   = var.ENABLE_KEY_ROTATION
  is_enabled                            = var.KMS_IS_ENABLED
  key_usage                             = var.KEY_USAGE
  policy                                = var.KMS_POLICY
  tags                                  = merge(var.KMS_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#

#kms_alias
#https://www.terraform.io/docs/providers/aws/r/kms_alias.html
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_kms_alias" "template_kms_alias" {
  name          = "alias/${var.PROJECT_NAME}-${var.ENVIRONMENT}-kms"
  target_key_id = aws_kms_key.template_key.key_id
}
#--------------------------------------------------------------------------------------------------------------------#
