variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-west-2"
}

variable "ami_id" {
  description = "AMI ID for the Ubuntu image"
  default     = "ami-xxxxxxxxxxxxxxxxx"  # Change to your desired Ubuntu AMI ID
}

variable "key_pair" {
  description = "Key Pair Name"
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID"
  default     = ""
}

variable "security_group" {
  description = "Security Group ID"
  default     = ""
}

variable "app_port" {
  description = "Port exposed to Docker image"
  default     = "80"
}

variable "app_image" {
  description = "Docker image to run this in ECS cluster"
  default     = "nginx:latest"
}
