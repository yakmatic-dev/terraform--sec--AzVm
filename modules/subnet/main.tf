resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.local_alpha_address_space]
}
