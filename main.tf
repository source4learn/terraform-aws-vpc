# AWS VPC
terraform {
  required_version = ">= 0.12.0"
}

# AWS VPC Resources
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr}"

  tags = {
        Name        = "${var.prefix}-${var.environment}"
        Environment = var.environment
    }
}

# AWS VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-${var.environment}"
    Environment = var.environment
  }
}