provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "webserver-rg"
  location = "East US"
}

module "network" {
  source              = "./modules/network"
  vnet_name           = "web-vnet"
  vnet_cidr           = "10.0.0.0/16"
  subnet_name         = "web-subnet"
  subnet_cidr         = "10.0.1.0/24"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "web-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "vm" {
  source              = "./modules/vm"
  vm_name             = "webserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.network.subnet_id
  nsg_id              = module.nsg.nsg_id
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
}

output "vm_public_ip" {
  value = module.vm.public_ip
}
