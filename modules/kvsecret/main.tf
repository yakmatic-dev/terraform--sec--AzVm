
resource "azurerm_key_vault_secret" "private_key" {
  count        = length(var.admin_users)
  name         = "ssh-key-${var.admin_users[count.index].username}"
  value        = var.private_keys[var.admin_users[count.index].username]
  key_vault_id = var.key_vault_id
  content_type = "ssh-private-key"
}


resource "azurerm_key_vault_secret" "public_key" {
  for_each     = var.public_keys
  name         = "ssh-${each.key}-public"
  value        = each.value
  key_vault_id = var.key_vault_id
  content_type = "ssh-public-key"
}

output "private_key_ids" {
  value = { for k, s in azurerm_key_vault_secret.private_key : k => s.id }
}

output "public_key_ids" {
  value = { for k, s in azurerm_key_vault_secret.public_key : k => s.id }
}
