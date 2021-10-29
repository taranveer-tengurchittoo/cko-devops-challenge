#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/lanch-template/outputs.tf
#description     :get information on the compute resources after creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#
output "launch_template_id" {
  value = aws_launch_template.template_launch_template.id
}
#--------------------------------------------------------------------------------------------------------------------#
