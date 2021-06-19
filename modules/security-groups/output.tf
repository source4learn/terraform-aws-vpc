output "public_security_group_ids" {
  value = aws_security_group.public_security_group.*.id
}

output "private_security_group_ids" {
  value = aws_security_group.private_security_group.*.id
}

output "storage_security_group_ids" {
  value = aws_security_group.storage_security_group.*.id
}