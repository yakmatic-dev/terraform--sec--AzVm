output "name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.main.name
}

output "location" {
  description = "Location of the Resource Group"
  value       = azurerm_resource_group.main.location
}
