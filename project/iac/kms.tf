#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/kms.tf
#description     : kms configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#kms
#--------------------------------------------------------------------------------------------------------------------#
module "cko-devops-challenge-kms" {
  #kms parameters
  source                                    = "../../terraform/aws-modules/kms"
  CUSTOMER_MASTER_KEY_SPEC                  = "SYMMETRIC_DEFAULT"
  KEY_USAGE                                 = "ENCRYPT_DECRYPT"
  KMS_IS_ENABLED                            = "true"
  KMS_POLICY                                = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "key-consolepolicy-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::528130383285:user/taranveer.tengurchittoo@checkout.com",
                  "arn:aws:sts::528130383285:assumed-role/tech/taranveer.tengurchittoo@checkout.com"
                  ]
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::528130383285:user/taranveer.tengurchittoo@checkout.com",
                  "arn:aws:sts::528130383285:assumed-role/tech/taranveer.tengurchittoo@checkout.com"
                  ]
            },
            "Action": [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::528130383285:user/taranveer.tengurchittoo@checkout.com",
                  "arn:aws:sts::528130383285:assumed-role/tech/taranveer.tengurchittoo@checkout.com"
                  ]
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:DescribeKey",
                "kms:GetPublicKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow attachment of persistent resources",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::528130383285:user/taranveer.tengurchittoo@checkout.com",
                  "arn:aws:sts::528130383285:assumed-role/tech/taranveer.tengurchittoo@checkout.com"
                  ]
            },
            "Action": [
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"
            ],
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                }
            }
        },
        {
            "Sid": "Allow attachment of persistent resources",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::528130383285:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
            },
            "Action": "kms:CreateGrant",
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                }
            }
        },
        {
            "Sid": "Allow service-linked role use of the CMK",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::528130383285:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
}
POLICY

  #tags
  KMS_TAGS                                  = {
      Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-kms"
      type = "kms"
  }
  PROJECT_NAME                                  = var.PROJECT_NAME
  ENVIRONMENT                                   = var.ENVIRONMENT
  PROJECT_WIDE_TAGS                             = var.PROJECT_WIDE_TAGS
}
#--------------------------------------------------------------------------------------------------------------------#
