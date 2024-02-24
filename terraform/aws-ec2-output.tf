output "manager_instance_ip_address" {
  description = "IP da instância manager"
  value       = aws_instance.manager.public_ip
}