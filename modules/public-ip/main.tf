resource "azurerm_public_ip" "vm1" {
  name                = var.name
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = var.allocation_method
}
