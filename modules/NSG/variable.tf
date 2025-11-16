variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}

variable "location" {
  type        = string
  description = "Location of the NSG"
}

variable "rg_name" {
  type        = string
  description = "Resource group name where NSG will be created"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "List of security rules"
  default     = []
}
