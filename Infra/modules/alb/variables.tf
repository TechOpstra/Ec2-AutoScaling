variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "tg_name" {
  description = "Name of the Target Group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}
