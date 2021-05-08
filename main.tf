# AWS VPC
terraform {
  required_version = ">= 0.12.0"
}

# AWS VPC Resources
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  tags = {
    Name        = "${var.cluster_prefix}-${var.cluster_environment}"
    Environment = var.cluster_environment
  }
}

# AWS VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.cluster_prefix}-${var.cluster_environment}"
    Environment = var.cluster_environment
  }
}

# AWS VPC Subnets Module - Public Subnet
module "public_subnet" {
  source                  = "./modules/subnets"
  vpc_id                  = aws_vpc.vpc.id
  aws_internet_gateway_id = aws_internet_gateway.igw.id
  subnet_bits             = var.subnet_bits
  cidr                    = var.cidr
  cluster_prefix          = var.cluster_prefix
  cluster_environment     = var.cluster_environment
  subnet_type             = ["public"]
}

# AWS NAT Gateway Module
module "nat_gateway" {
  source              = "./modules/nat-gateways"
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
  public_subnet_ids   = module.public_subnet.public_subnet_ids
}

# AWS VPC Subnets Module - Private Subnet
module "private_subnet" {
  source              = "./modules/subnets"
  vpc_id              = aws_vpc.vpc.id
  aws_nat_gateway_id  = module.nat_gateway.nat_gateway_ids
  cidr                = var.cidr
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
  subnet_bits         = var.subnet_bits
  subnet_type         = ["private", "storage"]
}

# AWS VPC Security Groups Module
module "security_group" {
  source              = "./modules/security-groups"
  vpc_id              = aws_vpc.vpc.id
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
}