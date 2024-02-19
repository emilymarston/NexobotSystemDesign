variable "aws_region" {
  description = "AWS region where resources will be provisioned"
}

variable "ami_id" {
  description = "AMI ID for the Ubuntu image"
}

variable "key_pair" {
  description = "Key Pair Name"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "security_group" {
  description = "Security Group ID"
}

# Define your database-related resources here
resource "aws_db_instance" "database_instance" {
  engine               = "mysql"  # Change as per your database engine
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
}
