variable "application" {
  description = "This is application name"
  type        = string

}
variable "environment" {
  description = "This describe the env name"
  type        = string
}
variable "primary_location" {
  description = "This is residing location"
  type        = string
}
variable "base_address_space" {
  description = "Base CIDR block for the VNet"
  type        = string
}

variable "rg_name" {
  description = "Resource Group name where the VNet will be created"
  type        = string
}
