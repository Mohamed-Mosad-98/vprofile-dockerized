####################################
# Project
####################################

project_name = "vprofile"

environment = "dev"

####################################
# AWS
####################################

aws_region = "eu-north-1"

####################################
# Network
####################################

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones = [
  "eu-north-1a",
  "eu-north-1b"
]

####################################
# EC2
####################################

instance_type = "t3.small"

key_name = "project-key"

####################################
# Application
####################################

app_port = 8080

second_app_port = 8081

####################################
# GitHub
####################################

github_repo = "https://github.com/Mohamed-Mosad-98/vprofile-dockerized.git"

####################################
# SSH
####################################

ssh_allowed_cidr = "156.204.10.160/32"

####################################
# Application Secrets
####################################

db_password       = "YourStrongPassword"
rabbitmq_user     = "admin"
rabbitmq_password = "YourRabbitPassword"

