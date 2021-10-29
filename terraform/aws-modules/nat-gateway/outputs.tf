#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/nat-gateway/outputs.tf
#description     :get outputs to be reused later on
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#
output "ng-id" {
  value = aws_nat_gateway.nat-gateway-template.id
}
#--------------------------------------------------------------------------------------------------------------------#