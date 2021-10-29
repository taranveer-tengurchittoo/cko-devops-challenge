#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/subnet/outputs.tf
#description     :get information on the subnet after its creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

output "subnet-id" {
  value = aws_subnet.subnet_template.id
}

