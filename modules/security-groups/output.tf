output "public_security_group_id" {
  value = module.public_security_group.security_group_id
}

output "private_security_group_id" {
  value = module.private_security_group.security_group_id
}

output "storage_security_group_id" {
  value = module.storage_security_group.security_group_id
}