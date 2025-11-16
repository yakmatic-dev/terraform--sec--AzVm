variable "application" {
  description = "app name"
  type        = string
}

variable "environment" {
  description = "env name"
  type        = string
}

variable "rg_name" {
  description = "Resource Group name where the Subnet will be created"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name where the Subnet will be created"
  type        = string
}

variable "local_alpha_address_space" {
  description = "Local alpha variable for address spaces"
  type        = string
}

variable "name" {
  description = "Name of the Subnet"
  type        = string
}
