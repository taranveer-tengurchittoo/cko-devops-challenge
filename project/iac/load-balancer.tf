#--------------------------------------------------------------------------------------------------------------------#
#title           :iac/load-balancer.tf
#description     :terraform module to create load_balancer
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-28
#version         :0.1
#--------------------------------------------------------------------------------------------------------------------#

#aws_alb
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_alb" "cko-devops-challenge-load-balancer-template" {
    #alb parameters
    drop_invalid_header_fields  = "true"
    enable_http2                = "true"
    idle_timeout                = 30
    internal                    = "false"
    load_balancer_type          = "application"
    name                        = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-load-balancer"
    security_groups             = [module.cko-devops-challenge-web-sg.sg-id]
    subnets                     = ["${module.cko-devops-challenge-web-subnet-a.subnet-id}","${module.cko-devops-challenge-web-subnet-b.subnet-id}","${module.cko-devops-challenge-web-subnet-c.subnet-id}"]

    #tags
    tags 		                                  = merge(
      {
        type = "elb"
        Name = "cko-devops-challenge-public-elb"
      },
      var.PROJECT_WIDE_TAGS,
    )   
  }
#aws_lb_listener
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_lb_listener" "cko-devops-challenge-load-balancer" {
  load_balancer_arn = aws_alb.cko-devops-challenge-load-balancer-template.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    # target_group_arn = module.cko-devops-challenge-app-tg-green.tg-arn
     forward {
       target_group {
         arn    = module.cko-devops-challenge-app-tg-blue.tg-arn
         weight = 50
       }

       target_group {
         arn    = module.cko-devops-challenge-app-tg-green.tg-arn
         weight = 50
       }

       stickiness {
         enabled  = true
         duration = 30
        }
      }
    }
}
#--------------------------------------------------------------------------------------------------------------------#
