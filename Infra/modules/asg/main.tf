# Security Group for ASG Instances
resource "aws_security_group" "asg_sg" {
  vpc_id = var.vpc_id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH (optional, for debugging)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ASG-Security-Group"
  }
}

# Launch Template for EC2 Instances
resource "aws_launch_template" "app" {
  name_prefix   = var.lt_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  # Enable Public IPv4 Address & Attach Security Group
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Ecommerce-ASG-Instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  desired_capacity     = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [var.tg_arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Ecommerce-ASG"
    propagate_at_launch = true
  }
}

# CloudWatch Alarm - Scale Out (Increase instances)
resource "aws_cloudwatch_metric_alarm" "scale_out" {
  alarm_name          = "scale-out-alarm"
  metric_name        = "CPUUtilization"
  namespace         = "AWS/EC2"
  statistic         = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold         = var.cpu_scale_out_threshold  # Dynamic threshold
  period           = 60
  evaluation_periods = 2
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}


# CloudWatch Alarm - Scale In (Decrease instances)
resource "aws_cloudwatch_metric_alarm" "scale_in" {
  alarm_name          = "scale-in-alarm"
  metric_name        = "CPUUtilization"
  namespace         = "AWS/EC2"
  statistic         = "Average"
  comparison_operator = "LessThanThreshold"
  threshold         = var.cpu_scale_in_threshold  # Dynamic threshold
  period           = 60
  evaluation_periods = 2
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}

resource "aws_sns_topic" "alerts" {
  name = "cpu-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "sbvh1437@gmail.com"  
}

output "launch_template_id" {
  description = "ID of the Launch Template used for ASG instances"
  value       = aws_launch_template.app.id
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "asg_security_group_id" {
  description = "Security Group ID attached to ASG instances"
  value       = aws_security_group.asg_sg.id
}

output "scale_out_alarm_arn" {
  description = "ARN of the CloudWatch alarm for scale-out action"
  value       = aws_cloudwatch_metric_alarm.scale_out.arn
}

output "scale_in_alarm_arn" {
  description = "ARN of the CloudWatch alarm for scale-in action"
  value       = aws_cloudwatch_metric_alarm.scale_in.arn
}
