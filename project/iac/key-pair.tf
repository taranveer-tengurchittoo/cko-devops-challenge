#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/key-pair.tf
#description     : key-pair configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            : 2021-10-28
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#key
#https://www.terraform.io/docs/providers/aws/r/key_pair.html
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_key_pair" "key_template" {
	#key pair parameters
	key_name                              = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-key-pair"
	public_key                            = file("~/.ssh/ckc-dev-key_pair.pub")
	
	#tags
	tags                                  = merge(var.KEY_TAGS, var.PROJECT_WIDE_TAGS)
}
#--------------------------------------------------------------------------------------------------------------------#
