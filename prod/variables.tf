variable "aws_region" {
    description     = "AWS region where resources will be provided"
    default         = string
}

variable "ami_id" {
    description     = "AMI ID for the Ubuntu image"
    type            = string
}

variable "key_pair" {
    description     = "Key Pair Name"
    type            = string
}

variable "subnet_id" {
    description     = "Subnet ID"
    type            = string
}

variable "security_group" {
    description     = "Security Group ID"
    type            = string
}