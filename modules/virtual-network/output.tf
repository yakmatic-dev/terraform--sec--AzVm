output "alpha_address_space" {
  value = local.alpha_address_space
}
output "beta_address_space" {
  value = local.beta_address_space
}
output "name" {
  value = azurerm_virtual_network.main.name
}
