# Output the full list of admin user objects
output "admin_users" {
  value       = var.admin_users
  description = "List of admin user objects"
}

# Map of usernames to their private keys (sensitive)
output "private_keys" {
  value       = { for i, u in var.admin_users : u.username => tls_private_key.ssh[i].private_key_pem }
  description = "Map of usernames to their private keys"
  sensitive   = true
}

# Map of usernames to their public keys
output "public_keys" {
  value       = { for i, u in var.admin_users : u.username => tls_private_key.ssh[i].public_key_openssh }
  description = "Map of usernames to their public keys"
}


/*output "private_keys" {
  value = {
    for i, user in var.admin_users :
    user.username => tls_private_key.ssh[i].private_key_pem
  }
  #sensitive = true
}

output "public_keys" {
  value = {
    for i, user in var.admin_users :
    user.username => tls_private_key.ssh[i].public_key_openssh
  }
}
*/
