#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/provider.tf
#description     : provider configuration file for terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-27
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws
#https://www.terraform.io/docs/providers/aws/index.html
#--------------------------------------------------------------------------------------------------------------------#
provider "aws" {
  region                                            = var.AWS_REGION
  profile                                           = var.AWS_PROFILE
  shared_credentials_file                           = var.CREDENTIALS_FILE
}
#--------------------------------------------------------------------------------------------------------------------#