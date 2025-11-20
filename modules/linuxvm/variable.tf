variable "vm_name" {
  description = "Name of virtual machine"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_size" {
  description = "VM SKU size"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "network_interface_ids" {
  description = "List of NIC IDs"
  type        = list(string)
}

variable "admin_ssh_keys" {
  description = "List of SSH key objects"
  type = list(object({
    username   = string
    public_key = string
  }))
  default = []
}

variable "os_disk" {
  description = "OS disk configuration"
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
}

/*variable "data_disks" {
  description = "List of extra data disks"
  type = list(object({
    lun                  = number
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  }))
  default = []
}*/

variable "image" {
  description = "Image reference object"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}


variable "admin_users" {
  type = list(object({
    username   = string
    public_key = optional(string)
  }))
}

variable "environment" {
  description = "env"
  type        = string
}
variable "application" {
  description = "app"
  type        = string
}
