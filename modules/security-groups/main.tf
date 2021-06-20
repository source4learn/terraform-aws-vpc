# AWS Public Security Group
resource "aws_security_group" "public_security_group" {
  count                  = var.cluster_architecture == "1-tier" || var.cluster_architecture == "2-tier" || var.cluster_architecture == "3-tier" ? 1 : 0
  name                   = "${var.cluster_prefix}-public"
  description            = "Allow connections from internet"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ssh connection inbound public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Allow http inbound public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow https inbound public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.cluster_prefix}-public"
    Environment = var.cluster_environment
    Type        = "public"
  }
}

# AWS Public Security Group Rules
# resource "aws_security_group_rule" "allow_http_inbound_public" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.public_security_group.id
# }

# resource "aws_security_group_rule" "allow_https_inbound_public" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.public_security_group.id
# }

# AWS Private Security Group
resource "aws_security_group" "private_security_group" {
  count                  = var.cluster_architecture == "2-tier" || var.cluster_architecture == "3-tier" ? 1 : 0
  name                   = "${var.cluster_prefix}-private"
  description            = "The private security group to allows inbound traffic from public group"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.cluster_prefix}-private"
    Environment = var.cluster_environment
    Type        = "private"
  }
}

# AWS Private Security Group Rules
resource "aws_security_group_rule" "allow_inbound_private" {
  count                    = var.cluster_architecture == "2-tier" || var.cluster_architecture == "3-tier" ? 1 : 0
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.public_security_group[0].id
  security_group_id        = aws_security_group.private_security_group[0].id
}

# AWS Storage Security Group
resource "aws_security_group" "storage_security_group" {
  count                  = var.cluster_architecture == "3-tier" ? 1 : 0
  name                   = "${var.cluster_prefix}-storage"
  description            = "The storage security group to allows inbound traffic from private group"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.cluster_prefix}-storage"
    Environment = var.cluster_environment
    Type        = "storage"
  }
}

# AWS Storage Security Group Rules
resource "aws_security_group_rule" "allow_inbound_storage" {
  count                    = var.cluster_architecture == "3-tier" ? 1 : 0
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.private_security_group[0].id
  security_group_id        = aws_security_group.storage_security_group[0].id
}
