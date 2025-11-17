variable "nic_name" {
  type = string
}

variable "application" {
  type = string
}

variable "environment" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "ip_configurations" {
  description = "List of IP configs for NIC"
  type = list(object({
    name                  = string
    subnet_id             = string
    private_ip_allocation = string
    private_ip            = optional(string)
    public_ip_id          = optional(string)
  }))
}
