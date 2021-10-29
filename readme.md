# CKO Devops Challenge solution by TTE

## TLDR | Quick start
This piece of code was created to build a highly-available and scalable three-tier web infrastructure in response to the CKO Devops Challenge. It hosts a Wordpress CMS.

It consists of:
1. an internet-facing ELB which handles traffic, 
2. an EC2 autoscaling group hosting the web application 
3. and an Aurora serverless RDS cluster,

all of which span 3 AZs.

For the purposes of this challenge, a bootstrap bash script was developed in replacement of a jenkins pipeline. It comes with a help section and can be used to create or destroy the infrastructure.

### Pre-requisites

Before testing it on your AWS account, make sure that: 
1. there are have 3 EIPs available in the region where you plan to deploy the infrastructure
2. you have necessary permissions to create AWS secrets, EC2 Autoscaling, IAM roles and policies, Internet Gateway, NAT Gateway, VPC, Route tables, Subnets and RDS cluster
3. the following variables in the provider section in `project/iac/terraform.tfvars` are modified to reflect your setup
    ```sh
    #provider
    AWS_PROFILE                         = "cko-playground"
    AWS_REGION                          = "ap-northeast-2"
    CREDENTIALS_FILE                    = "~/.aws/credentials"
    
    #vpc
    CIDR_BLOCK                          = "10.77" #creates a 10.77.0.0/16
    
    #my public IP
    MY_IP                               = "102.160.235.159" #used for web security group inbound rule
    ```
4. the ARNs for the user role used in the KMS Policy in `project/iac/kms.tf` are modified
    ```sh
    "Principal": {
                "AWS": [
                  "arn:aws:iam::528130383285:user/taranveer.tengurchittoo@checkout.com",
                  "arn:aws:sts::528130383285:assumed-role/tech/taranveer.tengurchittoo@checkout.com"
                  ]
            },
    ```

### To create the infrastructure:
```sh
cd project
bash bootstrap.sh -c
```

### To clean up the infrastructure:
```sh
cd project
bash bootstrap.sh -d
```

## Choices | Self evaluation on the exercise
### Understanding of the exercise
For the purposes of building a basic website with text and an image, I would have personally gone for an AWS CloudFront with an S3 as backend. It is scalable with far less operational overhead, however it would not not be fit for this exercise since most of the criteria on which I am supposed to be assessed would be missing. The reason for this choice is that using an S3 bucket alone with the hosting solution would incurr higher costs in the long run since web resources would need to be fetched every time a page is loaded. Having a CDN in front of the S3 bucket would decrease costs considerably by caching content and decreasing the number of GET requests on the bucket. This would also improving the site's TTFB and overall performance. AWS CDN benefits from AWS shield DDOS protection, TLS offloading and would also allow the use of the AWS WAF.

### Code Quality
I do not have a developer background (c++/php at University doesn't count much for me) but I've worked extensively with native Linux scripting languages (bash & python and a little bit less of perl/ruby/groovy). I try to keep the code dry and clean as possible but it's not always the case with Terraform (a concrete example would be the limitations in this very project when defining tags for the autoscaling group ;a set of map of strings is required causing duplication). 

I've tried modularizing the terraform components as far as possible but given the time some resources have been built in flat files.

Only terraform and bash have been used in this project.

### Design skills
To provide an HA scalable solution for a 3-tier web application, I have chosen
| Resource | Description | Explanation for choice | 
| ------ | ------ | ------ |
| Aurora Serverless  | Private - 3 AZs - allowing only EC2 AutoScaling inbound on port 3306 |Databases being the bottlneck in most cases, I have not chosen an RDS since scaling involves an operational overhead and often a micro-downtime. This is a natively HA and fault-tolerant scalable solution and will scale out and in providing the most cost-effective and durable solution and we wouldn't have to worry about changing usage patterns. |
| 2 EC2 Auto Scaling group |  Private - 3 AZs - allowing only ELB inbound on port 80. When servers come up, the userdata patches the server, tags it with a unique name, installs httpd, php-fpm, downloads wordpress and configures it to communicate with the database | Manually horizontal/vertical scaling EC2 instances is a pain and I've opted for two separate EC2 Auto Scaling groups (blue/green) here with a scaling policy that adds new servers in the ASG when average CPU usage goes above 70% and scales back in when average CPU is less than 40%.  |
| ELB with weighted target groups | Public - 3 AZs - allowing only only user IP on port 80 (listeners would ideally be on HTTPS with ACM)| ELBs are natively scalable except for sudden massive spikes of traffic which might require an ELB warmup. The ELB is sharing traffic equally across the blue and green ASGs. For deployment of new code, traffic would be shifted completely to one ASG. Code would be deployed and traffic would be gradually balanced back. One advantage is this would decrease the number of servers in the environment being tested making it even more cost-effective. With the ELB working at Layer 7, this adds a lot of possibilities in the way traffic is handled by watching for information in the HTTP header.|
| NAT Gateway | Public - 3 AZs - Allows NAT translation for each AZ| Allows EC2 to connect to the internet and be patched before processing live traffic|
| Internet Gateway | Attached to the VPC and allows NAT to route to the internt | Allows NAT Gateway to reach internet|
| KMS | N/A | Custom CMK to encrypt the database and EC2 volumes|
| AWS Secrets | N/A | The Aurora cluster needs to be built with a password and this will be stored in the terraform state. To prevent any security compromise, the bootstrap script will create an AWS secret, generate a password for the administrator user in memory and store it on the AWS secrets. The userdata for the ASG has a function that allows the first instance that connects to the database to reset the administrator password with the one stored on the secret. All subsequent instances use the password stored in the secret to to connect to the database|
| VPC | /16 is a bit overkill, a  | Custom VPC to segragate environment from anything in the default VPC|
| Database Subnet | 1 private /28 in each AZ for database  | Maximum reader nodes is 15 + 1 master node. /28 provides 33 usable addresses |
| Application Subnet | 1 private /27 in each AZ for ASGs  | 81 usable addresses allowing 40 instances in each ASG |
| Application Subnet | 1 private /28 in each AZ for ELBs  | 33 usable addresses largely enough for ELB |

In an ideal world and given more time, traffic would hit a CDN with static resources living in an S3 bucket and all the dynamic content being handled via the ELB. The blue and green web tiers would each have an EFS mount where the application code would reside and new instances spawned in the ASG would be able to handle traffic faster. An elasticache cluster would also be created to reduce the load on the RDS cluster for frequently accessed data. 

An ECS cluster would also be a choice for the application tier but code deployment would take a bit more time since docker images would need to be built pushed over to an ECR, the ECS scaled out and scaled back in to serve new content. In the present scenario, application code would be pushed to the EFS and all instances attached would have the updated application.

## Documentation
Not the best documentation in a readme but still sufficient to get an overview of the infrastructure 

I've designed the infrastructure to autoscale on its own. It's currently using scaling policies for the ASG and the Aurora Serverless has it's native scaling based on ACU. 

If the max instances in the ASG turn out to be insufficient, the max and min size variables in `project/iac/autoscaling.tf` can be modified. 

```sh
module "cko-devops-challenge-app-asg-blue" {

    #asg parameters
          source                      = "../../terraform/aws-modules/autoscaling"
          CATEGORY                    = "blue"
          DEFAULT_COOLDOWN            = 120
          DESIRED_CAPACITY            = 2
          ENVIRONMENT                 = var.ENVIRONMENT
          HEALTH_CHECK_GRACE_PERIOD   = 240
          LAUNCH_TEMPLATE             = module.cko-devops-challenge-launch_template.launch_template_id
   >>>>>  MAX_SIZE                    = 5                                                              
   >>>>>  MIN_SIZE                    = 2
          PROJECT_NAME                = var.PROJECT_NAME
          SUBNET_1                    = module.cko-devops-challenge-app-subnet-a.subnet-id
          SUBNET_2                    = module.cko-devops-challenge-app-subnet-b.subnet-id
          SUBNET_3                    = module.cko-devops-challenge-app-subnet-c.subnet-id
```
If the Aurora needs to be scaled further, the variable for MIN & MAX capacity need to be modified in `project/iac/rds.tf`
```sh
module "cko-devops-challenge-rds" {
...
...
             #autoscaling
             AUTO_PAUSE                = "true"
    >>>>>    MAX_CAPACITY              = 16
    >>>>>    MIN_CAPACITY              = 2
             SECONDS_UNTIL_AUTO_PAUSE  = 300
```
## Test quality
Demo link here

## Ability to go the extra mile
### Monitoring/Alerting
1. Detailed monitoring has been enabled for the ASG and RDS
2. The current autoscaling already relies on CloudWatch metric alarm (see`/terraform/aws-modules/autoscaling/main.tf)` to scale up or down the ASG

Given time, I would 
1. Use prometheus+grafana for application/database metrics
2. Use grafana loki for aggregating logs from the web servers
3. Configure ELB + VPC flow logs

### Security
1. Only the web tier containing the ELBs are in a public subnet
2. Security groups allow a tier to communicate with the adjacent tiers only
3. KMS has been used to encrypt the RDS and EBS volumes
4. Database password is stored on secrets and reset by the first ASG instance on boot
5. Servers are patched before handling traffic
6. AWS SSM Session Manager is used to connect to the instances reducing the need for a bastion host
7. It provides a zero-patch solution, just scale out and in to have new patched instances
8. SSH key pair is of 4096 bits

Given time, I would 
1. Harden the linux image
2. Use a script to rotate the database password
3. Obscure use of the database password in the wordpress configuration file
4. Configure a TLS listener and WAF for the ELB
5. Implement TLS connection between the ELB and the ASG

### Automation
1. I've made use of a bash script to bootstrap the project
2. The script creates the AWS secret, generates a hash and uploads it for future use
3. The script creates an SSH key pair for the project
2. Use a script to rotate the database password

Given time, I would 
1. Use a jenkins pipeline 
    * for building a packer AMI
    * building the infrastructure
    * handle traffic weight modifications
2. Configure a scheduled policy for the autoscaling to increase the max and minimum instance by 1 every day during LUW and then scale back to the usual configuration. This would recycle instances everyday, ensuring vulnerabilities are cleared.
3. Add an EFS mount for each ASG and build a pipeline that pushes new code on that EFS mount

### Network diagram

