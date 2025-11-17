resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "ip_configuration" {
    for_each = var.ip_configurations

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_allocation

      private_ip_address   = lookup(ip_configuration.value, "private_ip", null)
      public_ip_address_id = lookup(ip_configuration.value, "public_ip_id", null)
    }
  }
}
