resource "tls_private_key" "ssh" {
  count     = length(var.admin_users)
  algorithm = "RSA"
  rsa_bits  = 4096
}

/*resource "local_file" "private_key" {
  count           = length(var.admin_users)
  content         = tls_private_key.ssh[count.index].private_key_pem
  filename        = pathexpand("~/.ssh/${var.admin_users[count.index].username}")
  file_permission = "0600"
}*/

resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_users[0].username


  network_interface_ids = var.network_interface_ids

  # Dynamic SSH Keys - Fixed logic
  dynamic "admin_ssh_key" {
    for_each = var.admin_users
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key != null ? admin_ssh_key.value.public_key : tls_private_key.ssh[admin_ssh_key.key].public_key_openssh
    }
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  disable_password_authentication = true


}





/*dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_keys
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }*/

# -----------------------------
# Dynamic OS Disk
# -----------------------------


# -----------------------------
# Dynamic Additional Data Disks
# -----------------------------
/* dynamic "data_disk" {
    for_each = var.data_disks
    content {
      lun                  = data_disk.value.lun
      caching              = data_disk.value.caching
      storage_account_type = data_disk.value.storage_account_type
      disk_size_gb         = data_disk.value.disk_size_gb
    }
  }*/

# -----------------------------
# Dynamic Image Reference
# -----------------------------

