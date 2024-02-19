variable "aws_region" {
  description = "AWS region where resources will be provisioned"
}

# Define your ECS-related resources here
# ECS (Elastic Container Service) Module
module "ecs" {
  source = "./modules/ecs"

  cluster_name = "ecs-integrated"

  cluster_configuration = {
    # TODO add configurations here
  }

  # Add other ECS module-specific variables here

  services = {
    ecsdemo-frontend = {
      cpu    = 1024
      memory = 4096

      # Container definition(s)
      container_definitions = {
        # TODO Define your container definitions here
        # EC2 instance for NexOS 
      }

      service_connect_configuration = {
        # TODO Define your service connect configuration here
      }

      subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = "sg-12345678"
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

# Application Load Balancer
resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2"
  size = 40

  tags = {
    Name = "HelloWorld"
  }
}

# AWS Elasticsearch
resource "aws_elasticsearch_domain" "example_sqs_quqe" {
  domain_name                   = "example-elasticsearch"
  elasticsearch_version         = "7.10"

  # TODO add other configurations here
}

# Amazon SQS
resource "aws_sqs_queue" "example_sqs_queue" {
  name                            = "exmaple_sqs_queue"
  delay_seconds                   = 0
  max_message_size                = 256000
  message_retention_seconds       = 3450000 # 4 days
  receive_wait_time_seconds       = 0
  visibility_timeout_seconds      = 30

  # TODO add other configuraitons here
}