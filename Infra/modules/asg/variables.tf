variable "lt_name" {
  description = "Name prefix for the Launch Template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ASG"
  type        = string
}

variable "user_data" {
  description = "Base64 encoded user data script for instance initialization"
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

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ASG placement"
  type        = list(string)
}

variable "tg_arn" {
  description = "Target Group ARN for ALB integration"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ASG instances will be launched"
  type        = string
}

variable "cpu_scale_out_threshold" {
  description = "CPU utilization threshold for scaling out"
  type        = number
}

variable "cpu_scale_in_threshold" {
  description = "CPU utilization threshold for scaling in"
  type        = number
}

variable "asg_name" {
  description = "The name of the Auto Scaling Group to monitor"
  type        = string
}
