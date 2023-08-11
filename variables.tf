# AWS region
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "aws region"
}

# VPC name
variable "vpc_name" {
  type        = string
  default     = "project-vpc"
  description = "name of VPC"
}

# VPC CIDR
variable "vpc_cidr" {
  type        = string
  default     = "172.20.0.0/20"
  description = "VPC CIDR block"
}

# Public subnets CIDR list
variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.1.0/24", "172.20.2.0/24"]
  description = "public subnets CIDR"
}

# Private app subnets CIDR list
variable "private_app_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.3.0/24", "172.20.4.0/24"]
  description = "private app subnets CIDR"
}

# Private db subnets CIDR list
variable "private_db_subnets_cidr" {
  type        = list(string)
  default     = ["172.20.5.0/24", "172.20.6.0/24"]
  description = "private database subnets CIDR"
}

# Subnets availability zones
variable "az" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "availability zones"
}

# RDS subnet group name
variable "wordpressdb_subnet_grp" {
  type        = string
  default     = "wordpress-db-subnet-grp"
  description = "name of RDS subnet group"
}

# RDS primary instance identity
variable "primary_rds_identifier" {
  type        = string
  default     = "wordpress-rds-instance"
  description = "Identifier of primary RDS instance"
}

# RDS replica identity
variable "replica_rds_identifier" {
  type        = string
  default     = "wordpress-rds-instance-replica"
  description = "Identifier of replica RDS instance"
}

# Type of RDS instance
variable "db_instance_type" {
  type        = string
  default     = "db.t2.micro"
  description = "type/class of RDS database instance"
}

# RDS instance name
variable "database_name" {
  type        = string
  default     = "wordpress_DB"
  description = "name of RDS instance"
}

# RDS instance username
variable "database_user" {
  type        = string
  sensitive   =   true
  description = "name of RDS instance user"
}

# RDS instance password
variable "database_password" {
  type        = string
  sensitive   = true
  description = "password to RDS instance"
}

# ID of EC2 instance AMI
variable "ami" {
  type        = string
  default     = "ami-0261755bbcb8c4a84"
  description = "ID of Instance AMI"
}

# Type of instance
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type/class of instance"
}

# AWS keypair
variable "ssh_key_pair" {
  type        = string
  default     = "default"
  description = "name of AWS SSH key-pair"
}

# Domain name
variable "domain" {
  type        = string
  default     = "liliangaladima.website"
  description = "domain name"
}

# Sub-domain name
variable "subdomain" {
  type        = string
  default     = "wordpress.liliangaladima.website"
  description = "name of sub domain"
}
