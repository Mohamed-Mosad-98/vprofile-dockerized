####################################
# Project Information
####################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

####################################
# AWS Configuration
####################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

####################################
# Networking
####################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

####################################
# EC2
####################################

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
}

####################################
# Application
####################################

variable "app_port" {
  description = "VProfile Port"
  type        = number
}

variable "second_app_port" {
  description = "Second Application Port"
  type        = number
}

####################################
# GitHub
####################################

variable "github_repo" {
  description = "GitHub Repository"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the EC2 instance"
  type        = string
}

####################################
# Application Secrets
####################################

variable "db_password" {
  description = "MySQL Root Password"
  type        = string
  sensitive   = true
}

variable "rabbitmq_user" {
  description = "RabbitMQ Username"
  type        = string
}

variable "rabbitmq_password" {
  description = "RabbitMQ Password"
  type        = string
  sensitive   = true
}



