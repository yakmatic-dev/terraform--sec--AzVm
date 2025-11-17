module "resource_group" {
  source           = "./modules/resource-group"
  application      = var.application
  environment      = var.environment
  primary_location = var.primary_location
}

module "virtual_network" {
  source             = "./modules/virtual-network"
  vnet_name          = "vnet-${var.application}-${var.environment}"
  application        = var.application
  environment        = var.environment
  rg_name            = module.resource_group.name
  primary_location   = module.resource_group.location
  base_address_space = var.base_address_space
}

module "subnet" {
  source                    = "./modules/subnet"
  name                      = "subnet-alpha"
  application               = var.application
  environment               = var.environment
  rg_name                   = module.resource_group.name
  vnet_name                 = module.virtual_network.name
  local_alpha_address_space = module.virtual_network.alpha_address_space

}

module "nsg" {
  source      = "./modules/NSG"
  nsg_name    = "nsg-${var.application}-${var.environment}"
  application = var.application
  environment = var.environment
  location    = module.resource_group.location
  rg_name     = module.resource_group.name

  security_rules = [
    {
      name                       = "ssh-allow"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  ]
}

module "nsg_association" {
  source      = "./modules/NSG-association"
  application = var.application
  environment = var.environment
  subnet_id   = module.subnet.id
  nsg_id      = module.nsg.id
}

module "public_ip" {
  source            = "./modules/public-ip"
  application       = var.application
  environment       = var.environment
  name              = "pip-${var.application}-${var.environment}-01"
  rgname            = module.resource_group.name
  location          = module.resource_group.location
  allocation_method = "Static"
}


module "nic" {
  source      = "./modules/NIC"
  nic_name    = "nic-${var.application}-${var.environment}-01"
  application = var.application
  environment = var.environment
  rg_name     = module.resource_group.name
  location    = module.resource_group.location

  ip_configurations = [
    {
      name                  = "ipconfig1"
      subnet_id             = module.subnet.id
      private_ip_allocation = "Dynamic"
      public_ip_id          = module.public_ip.id
    }
  ]
}
