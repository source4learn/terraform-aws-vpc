# AWS Availability Zones
data "aws_availability_zones" "available_zones" {}

# AWS Subnets
resource "aws_subnet" "subnets" {
  vpc_id            = var.vpc_id
  count             = var.create > 0 ? length(data.aws_availability_zones.available_zones.names) : 0
  cidr_block        = cidrsubnet(var.cidr, var.subnet_bits, var.offset + count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]

  tags = {
    Name        = "${var.prefix}-${var.subnet_type}-${count.index + 1}"
    Environment = var.environment
    Type        = var.subnet_type
  }
}

# AWS Route Tables
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  count  = var.create > 0 ? length(data.aws_availability_zones.available_zones.names) : 0

  tags = {
    Name        = "${var.prefix}-${var.subnet_type}-${count.index + 1}"
    Environment = var.environment
    Type        = var.subnet_type
  }
}

# AWS Route Table - Subnet Association 
resource "aws_route_table_association" "subnet_association" {
  count           = var.create > 0 ? length(data.aws_availability_zones.available_zones.names) : 0
  subnet_id       = element(aws_subnet.subnets.*.id, count.index)
  route_table_id  = element(aws_route_table.route_table.*.id, count.index)
}
