#--------------------------------------------------------------------------------------------------------------------#
#title            : iac/iam-instance-profile.tf
#description      : IAM instance profile configuration via terraform
#author           : Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date             : 2021-10-28
#version          : 0.1
#--------------------------------------------------------------------------------------------------------------------#

#iam role 
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_iam_role" "ec2-instance-role" {
    #iam role paremeters
    assume_role_policy  = data.aws_iam_policy_document.ec2-instance-policy.json
    description         = "EC2 instance role for ${var.PROJECT_NAME} ${var.ENVIRONMENT}"
    name                = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ec2-instance-role"
    path                = "/"

    #tags
    tags                = var.PROJECT_WIDE_TAGS
}

#iam policy
#--------------------------------------------------------------------------------------------------------------------#
data "aws_iam_policy_document" "ec2-instance-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_policy" "cko-devops-challenge-secrets-ro-policy" {
    #iam policy paremeters
    name        = "cko-devops-challenge-secrets-ro-policy"
    path        = "/"
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "secretsmanager:GetResourcePolicy",
                    "secretsmanager:GetSecretValue",
                    "secretsmanager:DescribeSecret",
                    "secretsmanager:ListSecretVersionIds"
                ],
                "Resource": "arn:aws:secretsmanager:*:528130383285:secret:ckc-dc-secret*"
            },
            {
                "Sid": "VisualEditor1",
                "Effect": "Allow",
                "Action": [
                    "secretsmanager:GetRandomPassword",
                    "secretsmanager:ListSecrets"
                ],
                "Resource": "*"
            }
        ]
    })
}

#resource policy attachment
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_iam_role_policy_attachment" "ec2-instance-role-attachment-ro" {
    role       = aws_iam_role.ec2-instance-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ec2-instance-role-attachment-tagging" {
    role       = aws_iam_role.ec2-instance-role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
}
resource "aws_iam_role_policy_attachment" "ec2-instance-role-attachment-ssm" {
    role       = aws_iam_role.ec2-instance-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "ec2-instance-role-attachment-rds-ro" {
    role       = aws_iam_role.ec2-instance-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cko-devops-challenge-secrets-ro-policy" {
    role       = aws_iam_role.ec2-instance-role.name
    policy_arn = aws_iam_policy.cko-devops-challenge-secrets-ro-policy.arn
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
    name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ec2-instance-profile"
    path = "/"
    role = aws_iam_role.ec2-instance-role.id
    provisioner "local-exec" {
      command = "sleep 10"
    }
}
#--------------------------------------------------------------------------------------------------------------------#
