# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

# ALB Configuration
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "tg_name" {
  description = "Name of the Target Group"
  type        = string
}

# Auto Scaling Group (ASG) Configuration
variable "lt_name" {
  description = "Name prefix for the Launch Template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ASG"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
}

# CloudWatch Metrics
variable "cpu_scale_out_threshold" {
  description = "CPU utilization threshold for scaling out"
  type        = number
}

variable "cpu_scale_in_threshold" {
  description = "CPU utilization threshold for scaling in"
  type        = number
}
