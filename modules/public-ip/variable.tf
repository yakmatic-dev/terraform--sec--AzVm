variable "name" {
  type        = string
  description = "Name of the Public-ip"

}
variable "location" {
  type        = string
  description = "Location where the Public-ip will be created"
}

variable "application" {
  type        = string
  description = "app name"

}
variable "environment" {
  type        = string
  description = "env name"

}
variable "allocation_method" {
  type        = string
  description = "Allocation method for the Public-ip"
  default     = "Static"
}

variable "rgname" {
  description = "rg_name"
  type        = string
}
