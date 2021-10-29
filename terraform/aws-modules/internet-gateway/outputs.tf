#--------------------------------------------------------------------------------------------------------------------#
#title           :networking/outputs.tf
#description     :get information on the networking resources after creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

output "ig-id" {
  value = aws_internet_gateway.internet_gateway_template.id
}

