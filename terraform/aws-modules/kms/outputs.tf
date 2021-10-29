#--------------------------------------------------------------------------------------------------------------------#
#title           :aws-modules/kms/outputs.tf
#description     :get information on the KMS key after its creation
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

output "key-arn" {
  value = join(", ", aws_kms_key.template_key.*.arn)
}

output "key-id" {
  value = join(", ", aws_kms_key.template_key.*.key_id)
}
#--------------------------------------------------------------------------------------------------------------------#
