#--------------------------------------------------------------------------------------------------------------------#
#title           : iac/route-tables.tf
#description     : route table configuration via terraform
#author          : Taranveer TENGURCHITTOO (ttaraan7@gmail.com)
#date            : 2021-10-28
#version         : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#Route table
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
#--------------------------------------------------------------------------------------------------------------------#

resource "aws_default_route_table" "cko-devops-challenge-default-route-table" {
    default_route_table_id = module.cko-devops-challenge-vpc.default_route_table_id
    
    #solved issue for route https://www.reddit.com/r/Terraform/comments/q0ooel/aws_route_table_error/
    route                                     {
        cidr_block = "0.0.0.0/0"
        gateway_id = module.cko-devops-challenge-internet-gateway.ig-id
      }

    #tags
    tags 		                                  = merge(
      {
        type = "route-table"
        Name = "cko-devops-challenge-default-route-table"
      },
      var.PROJECT_WIDE_TAGS,
    )   
  }

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_route_table" "cko-devops-challenge-route-a" {
    vpc_id                                    = module.cko-devops-challenge-vpc.vpc-id
    route                                     {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = module.cko-devops-challenge-ng-a.ng-id
      }
    tags 		                                  = merge(
      {
        type = "route-table"
        Name = "cko-devops-challenge-route-a"
      },
      var.PROJECT_WIDE_TAGS,
    )   
  }

resource "aws_route_table" "cko-devops-challenge-route-b" {
    vpc_id                                    = module.cko-devops-challenge-vpc.vpc-id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = module.cko-devops-challenge-ng-b.ng-id
      }
    tags 		                                  = merge(
      {
        type = "route-table"
        Name = "cko-devops-challenge-route-b"
      },
      var.PROJECT_WIDE_TAGS,
    )   
  }

resource "aws_route_table" "cko-devops-challenge-route-c" {
    vpc_id                                    = module.cko-devops-challenge-vpc.vpc-id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = module.cko-devops-challenge-ng-c.ng-id
      }
    tags 		                                  = merge(
      {
        type = "route-table"
        Name = "cko-devops-challenge-route-c"
      },
      var.PROJECT_WIDE_TAGS,
    )   
  }


resource "aws_route_table_association" "cko-devops-challenge-route-a" {
  subnet_id      = module.cko-devops-challenge-app-subnet-a.subnet-id
  route_table_id = aws_route_table.cko-devops-challenge-route-a.id
}


resource "aws_route_table_association" "cko-devops-challenge-route-b" {
  subnet_id      = module.cko-devops-challenge-app-subnet-b.subnet-id
  route_table_id = aws_route_table.cko-devops-challenge-route-b.id
}

resource "aws_route_table_association" "cko-devops-challenge-route-c" {
  subnet_id      = module.cko-devops-challenge-app-subnet-c.subnet-id
  route_table_id = aws_route_table.cko-devops-challenge-route-c.id
}
#--------------------------------------------------------------------------------------------------------------------#
