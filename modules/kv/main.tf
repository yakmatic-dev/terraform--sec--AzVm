resource "random_string" "kv_suffix" {
  length  = 6
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "main" {
  name                       = "kv-linuxvm-${random_string.kv_suffix.result}"
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name                   #"standard"
  soft_delete_retention_days = var.soft_delete_retention_days #7
  purge_protection_enabled   = var.purge_protection_enabled   #false

  rbac_authorization_enabled = var.rbac_authorization_enabled #true
}


resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = "diag-${azurerm_key_vault.main.name}"
  target_resource_id = azurerm_key_vault.main.id
  #storage_account_id = azurerm_storage_account.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

