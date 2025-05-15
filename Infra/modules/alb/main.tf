# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic (optional)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ALB to communicate with EC2 instances
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-Security-Group"
  }
}

# Create Application Load Balancer (ALB)
resource "aws_lb" "app_lb" {
  name               = var.alb_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "Ecommerce-ALB"
  }
}

# Create Target Group for Load Balancer
resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }
}

# Create ALB Listener to Forward Requests
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


output "alb_sg_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.app_lb.arn
}

output "tg_arn" {
  description = "ARN of the ALB Target Group"
  value       = aws_lb_target_group.tg.arn
}
