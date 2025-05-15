module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "Ecommerce-VPC"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

# Auto Scaling Group (ASG) Module with CloudWatch integrated
module "asg" {
  source               = "./modules/asg"
  lt_name              = "Ecommerce-LT"
  ami_id               = "ami-12345678"
  instance_type        = "t3.micro"
  desired_capacity     = 2
  max_size             = 5
  min_size             = 1
  public_subnet_ids    = module.vpc.public_subnet_ids
  tg_arn               = module.alb.tg_arn
  vpc_id               = module.vpc.vpc_id
  user_data            = filebase64("./userdata/nginx.sh")
  cpu_scale_out_threshold = 70  # Integrated CloudWatch metrics
  cpu_scale_in_threshold  = 30
}

module "alb" {
  source            = "./modules/alb"
  alb_name          = "Ecommerce-ALB"
  tg_name           = "Ecommerce-TG"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}
