variable "aws_region" {
  description = "AWS region where resources will be provisioned"
}

# Define your ECS-related resources here
# Note: ECS Fargate configurations will be specific to your application and Docker containers
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-ecs-cluster"
}