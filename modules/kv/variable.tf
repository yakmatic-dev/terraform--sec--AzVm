variable "rg_name" {
  description = "Resource Group name"
  type        = string

}
variable "location" {
  description = "Azure region"
  type        = string
}
variable "application" {
  description = "app name"
  type        = string
}
variable "environment" {
  description = "env name"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace to link to the Key Vault diagnostics"
  type        = string

}


variable "sku_name" {
  description = "The SKU name of the Key Vault"
  type        = string
  default     = "standard"
}
variable "soft_delete_retention_days" {
  description = "The number of days that deleted Key Vaults are retained"
  type        = number
  default     = 7
}
variable "purge_protection_enabled" {
  description = "Specifies whether purge protection is enabled for this Key Vault"
  type        = bool
  default     = false
}
variable "rbac_authorization_enabled" {
  description = "Specifies whether RBAC authorization is enabled for this Key Vault"
  type        = bool
  default     = true
}
