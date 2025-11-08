locals {
  alpha_address_space = cidrsubnet(var.base_address_space, 2, 0)
}

locals {
  beta_address_space = cidrsubnet(var.base_address_space, 2, 1)
}


resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.application}-${var.environment}"
  location            = var.primary_location
  resource_group_name = var.rg_name
  address_space       = [var.base_address_space]
}
