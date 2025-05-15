#aws region
region = "us-east-1"

# VPC Configuration
vpc_cidr            = "10.0.0.0/16"
vpc_name            = "Ecommerce-VPC"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-east-1a", "us-east-1b"]

# ALB Configuration
alb_name = "Ecommerce-ALB"
tg_name  = "Ecommerce-TG"

# Auto Scaling Group (ASG) Configuration
lt_name          = "Ecommerce-LT"
ami_id           = "ami-084568db4383264d4" 
instance_type    = "t2.micro"
desired_capacity = 2
max_size         = 5
min_size         = 1
user_data        = "userdata/nginx.sh"  

# CloudWatch Metrics for Scaling
cpu_scale_out_threshold = 50
cpu_scale_in_threshold  = 30
