# AWS Availability Zones
data "aws_availability_zones" "available_zones" {}

# AWS Elastic IPs
resource "aws_eip" "eip" {
  vpc   = true
  count = var.cluster_architecture == "2-tier" || var.cluster_architecture == "3-tier" ? length(data.aws_availability_zones.available_zones.names) : 0

  tags = {
    Name        = "${var.cluster_prefix}-${count.index + 1}"
    Environment = var.cluster_environment
  }
}

# AWS NAT Gateway Binding - Public Subnets
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id     = element(var.public_subnet_ids, count.index)
  count         = var.cluster_architecture == "2-tier" || var.cluster_architecture == "3-tier" ? length(data.aws_availability_zones.available_zones.names) : 0

  tags = {
    Name        = "${var.cluster_prefix}-${count.index + 1}"
    Environment = var.cluster_environment
  }
}
