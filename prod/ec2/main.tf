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

# Define your EC2-related resources here
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_pair
  subnet_id     = var.subnet_id
  tags = {
    Name = "Example EC2 Instance"
  }
}

resource "aws_sqs_queue" "queue_worker" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue_worker_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}

# Output the EC2 instance's ID
output "ec2_instance_id" {
  value = aws_instance.example_instance.id
}