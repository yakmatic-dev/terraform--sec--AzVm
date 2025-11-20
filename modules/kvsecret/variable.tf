variable "key_vault_id" {
  description = "The ID of the Azure Key Vault where secrets will be stored"
  type        = string
}

variable "admin_users" {
  description = "List of admin users for the VM"
  type = list(object({
    username = string
  }))
}

variable "private_keys" {
  description = "Map of usernames to their private SSH keys"
  type        = map(string)
}

variable "public_keys" {
  description = "Map of usernames to their public SSH keys"
  type        = map(string)
}
