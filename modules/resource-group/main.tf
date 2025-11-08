resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application}-${var.environment}"
  location = var.primary_location

}
