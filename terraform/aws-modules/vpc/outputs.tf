#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/vpc/outputs.tf
#description     :get information on the vpc after its creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

output "vpc-id" {
  value = aws_vpc.vpc_template.id
}

output "default_route_table_id" {
  value = aws_vpc.vpc_template.default_route_table_id
}