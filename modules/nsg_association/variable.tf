variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate the NSG with"
}

variable "nsg_id" {
  type        = string
  description = "The ID of the network security group to associate"
}

variable "application" {
  type        = string
  description = "app name"
}

variable "environment" {
  type        = string
  description = "env name"
}
