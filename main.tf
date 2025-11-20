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
  source      = "./modules/nsg"
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
  source      = "./modules/nsg-association"
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
  source      = "./modules/nic"
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

module "vm" {
  source = "./modules/linuxvm"

  vm_name        = "linuxvm1"
  rg_name        = module.resource_group.name
  location       = module.resource_group.location
  vm_size        = "Standard_B2ms"
  admin_username = "yakmat"
  environment    = var.environment
  application    = var.application



  # Attach NIC(s)
  network_interface_ids = [
    module.nic.id
  ]

  # Dynamic SSH users
  admin_users = [
    { username = "yakmat" },
    { username = "admin2" }
  ]

  # Optional: manually provided SSH keys
  # admin_ssh_keys = [
  #   {
  #     username   = "yakmat"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }
  # ]

  # OS disk configuration
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64
  }

  # Optional: additional data disks
  # data_disks = [
  #   {
  #     lun                  = 0
  #     caching              = "ReadOnly"
  #     storage_account_type = "Premium_LRS"
  #     disk_size_gb         = 128
  #   }
  # ]

  # VM image configuration
  image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


module "kv" {
  source                     = "./modules/kv"
  rg_name                    = module.resource_group.name
  location                   = module.resource_group.location
  sku_name                   = "standard"
  rbac_authorization_enabled = true
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  application                = var.application
  environment                = var.environment

}

module "kv_secret" {
  source       = "./modules/kvsecret"
  key_vault_id = module.kv.id
  admin_users  = module.vm.admin_users
  private_keys = module.vm.private_keys
  public_keys  = module.vm.public_keys
  depends_on   = [module.kv]

}
