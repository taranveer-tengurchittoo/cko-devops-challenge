#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/target-group/outputs.tf
#description     :get information on the compute resources after creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#
output "tg-id" {
  value = join(", ", aws_lb_target_group.target_group_template.*.id)
}

output "tg-arn" {
  value = join(", ", aws_lb_target_group.target_group_template.*.arn)
}
#--------------------------------------------------------------------------------------------------------------------#
