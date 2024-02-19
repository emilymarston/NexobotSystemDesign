terraform {
  backend "s3" {
    bucket         = "prod-tfstate-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "prod-tfstate-lock"
  }

  cloud {
    organization = "Nexobot"
    workspaces {
      name = "Nexobot - prod"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.aws_region
}

# Module References
module "cache" {
  source          = "./modules/cache"
  aws_region      = var.aws_region
  ami_id          = var.ami_id
  key_pair        = var.key_pair
  subnet_id       = var.subnet_id
  security_group  = var.security_group
}

module "database" {
  source          = "./modules/database"
  aws_region      = var.aws_region
  ami_id          = var.ami_id
  key_pair        = var.key_pair
  subnet_id       = var.subnet_id
  security_group  = var.security_group
}

module "ec2" {
  source          = "./modules/ec2"
  aws_region      = var.aws_region
  ami_id          = var.ami_id
  key_pair        = var.key_pair
  subnet_id       = var.subnet_id
  security_group  = var.security_group
}

module "ecs" {
  source          = "./modules/ecs"
  aws_region      = var.aws_region
  # Add other module-specific variables
}

/* module "load_balancer" {
  source          = "./modules/load_balancer"
  aws_region      = var.aws_region
  subnet_ids      = [var.subnet_id]
  security_groups = [module.ec2.security_group_id]
  # Add other module-specific variables
} */

# Docker Compose definition 
resource "null_resource" "run_docker_compose" {
  provisioner "local-exec" {
    command = "docker-compose up -d"
  }
  
  depends_on = [
    module.cache,
    module.database,
    module.ec2,
    module.ecs,
    module.load_balancer
  ]
}
