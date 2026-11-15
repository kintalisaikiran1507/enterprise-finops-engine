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

resource "aws_vpc" "app_vpc" {
  cidr_block = "10.20.0.0/16"

  tags = {
    Environment = "Prod"
    Service     = "log-pipeline"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Environment = "Prod"
    Service     = "log-pipeline"
  }
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"

  tags = {
    Environment = "Prod"
    Service     = "log-pipeline"
  }
}

resource "aws_nat_gateway" "prod_nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Environment = "Prod"
    Service     = "log-pipeline"
  }
}
