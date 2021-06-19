#  AWS Security Group
# resource "aws_security_group" "security_group" {
#   name                   = "${var.cluster_prefix}-${var.sg_type}"
#   description            = var.sg_description
#   vpc_id                 = var.vpc_id
#   revoke_rules_on_delete = true

#   egress {
#     from_port        = 0
#     to_port          = 65535
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.cluster_prefix}-${var.sg_type}"
#     Environment = var.cluster_environment
#     Type        = var.sg_type
#   }
# }

# AWS Outbound Security Group Rule
# resource "aws_security_group_rule" "security_group_rule" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.security_group.id
# }
