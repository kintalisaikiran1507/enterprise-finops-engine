terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

# Optimized & Policy-Compliant Setup: Graviton3 ARM64 + gp3 + Private IP only
resource "aws_instance" "app_server" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "m7g.xlarge"
  associate_public_ip_address = false

  root_block_device {
    volume_size = 500
    volume_type = "gp3"
  }

  volume_tags = {
    Environment = "Prod"
    Service     = "order-processing"
  }

  tags = {
    Environment = "Prod"
    Service     = "order-processing"
  }
}

# Zero-cost VPC Gateway Endpoint to eliminate NAT Gateway S3 data processing fees
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = "Prod"
    Service     = "order-processing"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Environment = "Prod"
    Service     = "order-processing"
  }
}
