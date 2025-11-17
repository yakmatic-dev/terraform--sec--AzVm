output "id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.vm1.id
}

output "ip_address" {
  description = "The allocated public IP address"
  value       = azurerm_public_ip.vm1.ip_address
}
