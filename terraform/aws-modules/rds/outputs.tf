#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/rds/outputs.tf
#description     :get information on the rds after its creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

output "rds-id" {
  value = aws_rds_cluster.rds_template.id
}

