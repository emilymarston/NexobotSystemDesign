# Define variables
variable "aws_region" {
  description = "AWS region where resources will be provisioned"
}

variable "subnet_id" {
  description = "Subnet ID where the Elasticache instance will be deployed"
}

variable "security_group" {
  description = "Security Group ID for the Elasticache instance"
}

variable "cache_instance_type" {
  description = "Instance type for the Elasticache instance"
  default     = "cache.t2.micro"  # Default to t2.micro instance type
}

# Module References
module "cache" {
  source             = "./modules/cache"
  aws_region         = var.aws_region
  subnet_id          = var.subnet_id
  security_group     = var.security_group
  cache_instance_type = var.cache_instance_type
}
