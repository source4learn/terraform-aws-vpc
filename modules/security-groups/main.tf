# AWS Public Security Group
module "public_security_group" {
  source          = "./resources"
  vpc_id          = var.vpc_id
  prefix          = var.prefix
  environment     = var.environment
  sg_type         = "public"
  sg_description  = "Allow connections from internet"
}

# AWS Public Security Group Rules
resource "aws_security_group_rule" "allow_http_inbound_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.public_security_group.security_group_id
}

resource "aws_security_group_rule" "allow_https_inbound_public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.public_security_group.security_group_id
}

# AWS Private Security Group
module "private_security_group" {
  source          = "./resources"
  vpc_id          = var.vpc_id
  prefix          = var.prefix
  environment     = var.environment
  sg_type         = "private"
  sg_description  = "The private security group to allows inbound traffic from public group"
}

# AWS Private Security Group Rules
resource "aws_security_group_rule" "allow_inbound_private" {
  type                      = "ingress"
  from_port                 = 0
  to_port                   = 65535
  protocol                  = "-1"
  source_security_group_id  = module.public_security_group.security_group_id
  security_group_id         = module.private_security_group.security_group_id
}

# AWS Storage Security Group
module "storage_security_group" {
  source          = "./resources"
  vpc_id          = var.vpc_id
  prefix          = var.prefix
  environment     = var.environment
  sg_type         = "storage"
  sg_description  = "The storage security group to allows inbound traffic from private group"
}

# AWS Storage Security Group Rules
resource "aws_security_group_rule" "allow_inbound_storage" {
  type                      = "ingress"
  from_port                 = 0
  to_port                   = 65535
  protocol                  = "-1"
  source_security_group_id  = module.private_security_group.security_group_id
  security_group_id         = module.storage_security_group.security_group_id
}