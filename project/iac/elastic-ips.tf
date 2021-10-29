#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/elastic-ips.tf
#description     : elastic ip configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-28
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#eip
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
#--------------------------------------------------------------------------------------------------------------------#
#eip for nat-gateaway-a
resource "aws_eip" "cko-devops-challenge-eip-a" {
  vpc      	= true
  tags 		=	merge(
    {
      type = "eip"
      Name = "cko-devops-challenge-eip-a"
    },
    var.PROJECT_WIDE_TAGS,
  )   
}
#eip for nat-gateaway-b
resource "aws_eip" "cko-devops-challenge-eip-b" {
  vpc      = true
  tags 		=	merge(
    {
      type = "eip"
      Name = "cko-devops-challenge-eip-b"
    },
    var.PROJECT_WIDE_TAGS,
  )   
}
#eip for nat-gateaway-c
resource "aws_eip" "cko-devops-challenge-eip-c" {
  vpc      	= true
  tags 		=	merge(
    {
      type = "eip"
      Name = "cko-devops-challenge-eip-c"
    },
    var.PROJECT_WIDE_TAGS,
  )   
}
#--------------------------------------------------------------------------------------------------------------------#
