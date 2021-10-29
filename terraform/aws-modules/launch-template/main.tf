#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/lanch-template/main.tf
#description     :terraform module to create launch configuration
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_vpc
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
#--------------------------------------------------------------------------------------------------------------------#

data "aws_ami" "amazon-linux" {

  most_recent      = true
  owners           = ["amazon"]

    filter {
      name   = "owner-alias"
      values = ["amazon"]
    }


    filter {
      name   = "name"
      values = ["amzn2-ami-hvm*"]
    }

	  filter {
	    name   				= "architecture"
	    values 				= ["x86_64"]
	  }

	  filter {
	    name   				= "root-device-type"
	    values 				= ["ebs"]
	  }
}
resource "aws_launch_template" "template_launch_template" {
  name_prefix                           = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-lt"
  block_device_mappings {
    device_name                         = "/dev/sda1"
    ebs {
        encrypted                       = var.ENCRYPTED
        kms_key_id                      = var.KMS_KEY_ARN
        volume_type                     = var.VOLUME_TYPE
        volume_size                     = var.ROOT_VOLUME_SIZE
        delete_on_termination           = "true"
    }
  }
  disable_api_termination               = var.DISABLE_API_TERMINATION
  ebs_optimized                         = true
  image_id                              = data.aws_ami.amazon-linux.id
  iam_instance_profile {
        name                            = var.IAM_INSTANCE_PROFILE
  }
  instance_initiated_shutdown_behavior  = "terminate"
  instance_type                         = var.INSTANCE_TYPE
  key_name                              = var.KEY_NAME
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address         = var.ASSOCIATE_PUBLIC_IP_ADDRESS
    security_groups                     = ["${var.SECURITY_GROUP}"]
   delete_on_termination                = "true"
  }
  tag_specifications {
    resource_type                       = "instance"
    tags                                = merge(var.INSTANCE_TAGS, var.PROJECT_WIDE_TAGS)
  }

  tag_specifications {
    resource_type                       = "volume"
    tags                                = merge(var.VOLUME_TAGS, var.PROJECT_WIDE_TAGS)
  }

  user_data = filebase64("${path.module}/userdata.sh")
}
