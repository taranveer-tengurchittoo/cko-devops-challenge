#--------------------------------------------------------------------------------------------------------------------#
#title           :iac/terraform.tfvars
#description     :override default variables
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#provider
AWS_PROFILE                         = "cko-playground"
AWS_REGION                          = "ap-northeast-2"
CREDENTIALS_FILE                    = "~/.aws/credentials"

#vpc
CIDR_BLOCK                          = "10.77" #creates a 10.77.0.0/16

#my public IP
MY_IP                               = "102.162.3.221"

#project tags
KEY_TAGS                            = {
    Name = "ckc-dev-key-pair"
    type = "key-pair"
}
PROJECT_WIDE_TAGS                   = {
    application            			    = "cko-devops-challenge-website"
    change-owner                    = "taranveer-tengurchittoo"
    environment                     = "development"
    product							            = "card-processing"
    product-owner                   = "taranveer-tengurchittoo"
    purpose                         = "CKO DevOps challenge evaluation"
    team                      		  = "cko-devops-challenge-candidate"
    terraformed                     = "true"
    ticket                          = "none"
}

ASG_TAGS = [
  {
    key                             = "type"
    value                           = "ec2-asg-instance"
    propagate_at_launch             = true

  },        

  {       
    key                             = "application"
    value                           = "cko-devops-challenge-website"
    propagate_at_launch             = true

  },        
    {       
    key                             = "change-owner"
    value                           = "taranveer-tengurchittoo"
    propagate_at_launch             = true
  },        

  {       
    key                             = "environment"
    value                           = "development"
    propagate_at_launch             = true
  },        
    {       
    key                             = "product"
    value                           = "card-processing"
    propagate_at_launch             = true
  },        
    {       
    key                             = "product-owner"
    value                           = "taranveer-tengurchittoo"
    propagate_at_launch             = true
  },        
    {       
    key                             = "purpose"
    value                           = "CKO DevOps challenge evaluation"
    propagate_at_launch             = true
  },        

    {       
    key                             = "team"
    value                           = "cko-devops-challenge-candidate"
    propagate_at_launch             = true
  },        
    {       
    key                             = "terraformed"
    value                           = "true"
    propagate_at_launch             = true
  },        
  {       
    key                             = "ticket"
    value                           = "none"
    propagate_at_launch             = true
  }
]

#These are not dry values but are still required for generating resource names that reflect the project and environment
PROJECT_NAME                        = "cko-dc"
ENVIRONMENT                         = "dev"

