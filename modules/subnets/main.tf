# AWS Availability Zones
data "aws_availability_zones" "available_zones" {}

# AWS Public Subnets
module "aws_public_subnet" {
  source              = "./resources"
  create              = contains(var.subnet_type, "public") ? 1 : 0
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
  vpc_id              = var.vpc_id
  cidr                = var.cidr
  subnet_bits         = var.subnet_bits
  subnet_type         = "public"
}

# AWS Private Subnets
module "aws_private_subnet" {
  source              = "./resources"
  create              = contains(var.subnet_type, "private") ? 1 : 0
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
  vpc_id              = var.vpc_id
  cidr                = var.cidr
  offset              = length(data.aws_availability_zones.available_zones.names)
  subnet_bits         = var.subnet_bits
  subnet_type         = "private"
}

# AWS Storage Subnets
module "aws_storage_subnet" {
  source              = "./resources"
  create              = contains(var.subnet_type, "storage") ? 1 : 0
  cluster_prefix      = var.cluster_prefix
  cluster_environment = var.cluster_environment
  cidr                = var.cidr
  vpc_id              = var.vpc_id
  offset              = 2 * length(data.aws_availability_zones.available_zones.names)
  subnet_bits         = var.subnet_bits
  subnet_type         = "storage"
}

# AWS Route Tables - Public Route
resource "aws_route" "public_route" {
  count                  = contains(var.subnet_type, "public") ? length(data.aws_availability_zones.available_zones.names) : 0
  route_table_id         = module.aws_public_subnet.route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.aws_internet_gateway_id
}

# AWS Route Tables - Private Route
resource "aws_route" "private_route" {
  count                  = contains(var.subnet_type, "private") ? length(data.aws_availability_zones.available_zones.names) : 0
  route_table_id         = module.aws_private_subnet.route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.aws_nat_gateway_id[count.index]
}
