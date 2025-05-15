terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "techopsbucket123"
    key          = "vpcec2/terraform.tfstateautoscale1"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
