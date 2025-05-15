# VPC Outputs
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

# ALB Outputs
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "tg_arn" {
  description = "ARN of the ALB Target Group"
  value       = module.alb.tg_arn
}

# Auto Scaling Group Outputs
output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "launch_template_id" {
  description = "The ID of the launch template used for ASG instances"
  value       = module.asg.launch_template_id
}

output "asg_security_group_id" {
  description = "Security Group ID attached to ASG instances"
  value       = module.asg.asg_security_group_id
}

output "scale_out_alarm_arn" {
  description = "ARN of the CloudWatch alarm for scale-out action"
  value       = module.asg.scale_out_alarm_arn
}

output "scale_in_alarm_arn" {
  description = "ARN of the CloudWatch alarm for scale-in action"
  value       = module.asg.scale_in_alarm_arn
}
