variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "EC2 Security Group ID"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository URL"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "db_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "rabbitmq_user" {
  description = "RabbitMQ username"
  type        = string
}

variable "rabbitmq_password" {
  description = "RabbitMQ password"
  type        = string
  sensitive   = true
}