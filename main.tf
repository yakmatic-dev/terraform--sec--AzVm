module "resource_group" {
  source           = "./modules/resource-group"
  application      = var.application
  environment      = var.environment
  primary_location = var.primary_location
}

module "virtual_network" {
  source             = "./modules/virtual-network"
  application        = var.application
  environment        = var.environment
  rg_name            = module.resource_group.name
  primary_location   = module.resource_group.location
  base_address_space = var.base_address_space
}

module "subnet" {
  source                    = "./modules/subnet"
  application               = var.application
  environment               = var.environment
  rg_name                   = module.resource_group.name
  vnet_name                 = module.virtual_network.name
  local_alpha_address_space = module.virtual_network.alpha_address_space

}
