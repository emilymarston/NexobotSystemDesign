variable "aws_region" {
  description = "AWS region where resources will be provisioned"
}

variable "subnet_ids" {
  description = "List of Subnet IDs"
  type        = list(string)
}

variable "security_groups" {
  description = "List of Security Group IDs"
  type        = list(string)
}

# Define your Load Balancer-related resources here
resource "aws_lb" "my_load_balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids
}