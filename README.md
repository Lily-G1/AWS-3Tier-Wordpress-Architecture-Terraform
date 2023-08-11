# AWS-3Tier-Wordpress-Architecture-with-Terraform
This terraform project automates the deployment of a 3-tier architecture in AWS with WordPress installed and configured on webservers. 
It creates a custom VPC network, webservers in private subnets, RDS instances in seperate private subnets, a bastion host and an application load balancer in
the public subnets. It also creates an S3 bucket that securely stores terraform's state files. 
For a detailed breakdown of this project, check out this *blog post..(link here)* where i describe each .tf configuration file and their respective functions  

## Prerequisites:  
- AWS CLI should be installed and configured with your access and secret keys  
- Terraform should be installed on your local machine

## Steps:  
- Clone this repo using command `git clone https://github.com/Lily-G1...... ` 
- Go to project folder: `cd terraform......`
- Change resources' data/settings to yours e.g resources' names, CIDRs, keypair, etc in the *variables.tf* file  
-  Initialize terraform `terraform init`
-  View Plan using `terraform plan`
-  Apply the plan using `terraform apply`
-  Destroy the resources `terraform destroy`      


