output "subnet_id" {
  description = "ID da subnet"
  value       = aws_subnet.cardapiogo_subnet.id
}

output "security_group_id" {
  description = "ID da security group"
  value       = aws_security_group.cardapiogo_sg.id
}