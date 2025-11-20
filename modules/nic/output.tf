/*output "nic_ids" {
  value = [for nic in azurerm_network_interface.main : nic.id]
}*/

output "id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.main.id
}





/*output "network_interface_id" {
  value = azurerm_network_interface.main.id
}*/
