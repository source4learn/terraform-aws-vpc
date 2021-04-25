output "public_subnet_ids" {
  value = module.aws_public_subnet.subnet_ids
}

output "public_route_table_ids" {
  value = module.aws_public_subnet.route_table_ids
}

output "private_subnet_ids" {
  value = module.aws_private_subnet.subnet_ids
}

output "private_route_table_ids" {
  value = module.aws_private_subnet.route_table_ids
}

output "storage_subnet_ids" {
  value = module.aws_storage_subnet.subnet_ids
}

output "storage_route_table_ids" {
  value = module.aws_storage_subnet.route_table_ids
}
