# AWS-3Tier-Wordpress-Architecture-with-Terraform
This terraform project automates the deployment of a 3-tier architecture in AWS with WordPress installed and configured on webservers. It creates the following resources:  
A custom VPC with 6 subnets: 2 public and 4 private, internet & NAT gateways, RDS MySQL databases & webservers in private subnets, security groups, a bastion host & an application load balancer in public subnets, an elastic file system, a Route53 hosted zone and autoscaling groups that create & scale bastion & webserver instances. It also creates an S3 bucket that securely stores terraform's state files.  

![3tierArch drawio](https://github.com/Lily-G1/AWS-3Tier-Wordpress-Architecture-Terraform/assets/104821662/8f0197c4-8c36-4b7f-9d10-6712e393c205)  

- The bastion/jump host & application load balancer reside in the public presentation layer  
- Wordpress application web servers are located in the private application layer  
- MySQL database & its standby replica are in the private database layer  

The entire project's code is seperated into various configuration files to make it easier to read, understand & maintain. For a detailed breakdown, check out this [blogpost](https://liliangaladima.hashnode.dev/terraform-deploying-a-3-tier-wordpress-architecture-on-aws) where i describe each .tf configuration file and their respective functions.  

## Prerequisites:  
- AWS CLI configured with your access and secret keys  
- Terraform installed on your local machine

## Steps:  
- Clone this repo using command `git clone https://github.com/Lily-G1/AWS-3Tier-Wordpress-Architecture-Terraform.git terraform_project`  
- Go to project folder: `cd terraform_project`  
- Go to s3 bucket folder: `cd s3-bucket-state`  
- Initalize terraform here & create bucket:  
  - `terraform init`  
  - `terraform plan`  
  - `terraform apply`
- Go back to main project directory `cd ..`
- You must specify your keypair in the *variables.tf* file  
- You may also change name of VPC, CIDR, subnet IP addresses, database name/type, etc in the *variables.tf* file  
- Initialize terraform, view project's creation plan & apply:  
- `terraform init`  
- `terraform plan`  
- `terraform apply`  
- At this point, you will be prompted for your sensitive values i.e database password & username  
- Creation of resources will take a few minutes. After a successful run, the load balancer's DNS endpoint will be exposed as defined in the *output.tf* file. Copy this URL & paste in your browser with "/wordpress" and you will be redirected to the official Wordpress admin/registration page:  

![Apache2 Ubuntu Default Page_ It works - Brave 8_4_2023 6_50_09 PM](https://github.com/Lily-G1/AWS-3Tier-Wordpress-Architecture-Terraform/assets/104821662/5806f4ca-81a0-4ff1-9b4b-e759ee86b148)  

- Route53's name servers will also be exposed. You can add them to your domain provider's site to propagate your domain  
- Destroy resources: `terraform destroy`  
- `cd ..`  
- `cd s3-bucket-state` and destroy S3 bucket as well  

## Important to Note:  
* If you're on the AWS free tier, all resources are free except for the NAT gateway which currently costs about $0.10/hour. Be sure to destroy your resources as soon as possible to avoid incremental charges

* Ideally, two NAT gateways should be created for redundancy; one in each public subnet (See architectural diagram). However, to avoid incurring excess charges, this project deploys just one  


