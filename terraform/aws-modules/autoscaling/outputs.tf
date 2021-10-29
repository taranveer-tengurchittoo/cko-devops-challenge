#--------------------------------------------------------------------------------------------------------------------#
#title           :compute/outputs.tf
#description     :get information on the compute resources after creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#
output "asg-id" {
  value = join(", ", aws_autoscaling_group.autoscaling_group_template.*.id)
}

output "asg-arn" {
  value = join(", ", aws_autoscaling_group.autoscaling_group_template.*.arn)
}


#--------------------------------------------------------------------------------------------------------------------#
