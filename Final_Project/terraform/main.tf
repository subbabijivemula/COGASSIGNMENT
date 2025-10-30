#######################################################
# Root Module: Full Environment Deployment
#######################################################

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#######################################################
# Networking Module
#######################################################

module "network" {
  source              = "./modules/network"
  region              = var.region
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_name         = var.subnet_name
  subnet_prefixes     = var.subnet_prefixes
  tags                = var.tags
}

#######################################################
# Network Security Group Module
#######################################################

module "nsg" {
  source              = "./modules/nsg"
  region              = var.region
  nsg_name            = var.nsg_name
  subnet_id           = module.network.subnet_id
  allowed_ports       = var.allowed_ports
  tags                = var.tags
}

#######################################################
# Virtual Machine Module
#######################################################

module "vm" {
  source              = "./modules/vm"
  region              = var.region
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  subnet_id           = module.network.subnet_id
  nsg_id              = module.nsg.nsg_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
}

#######################################################
# Patch Management Module
#######################################################

module "patch_management" {
  source              = "./modules/patch_management"
  region              = var.region
  vm_id               = module.vm.vm_id
  schedule_day        = var.patch_schedule_day
  schedule_time       = var.patch_schedule_time
  tags                = var.tags
}

#######################################################
# Outputs
#######################################################

output "vm_public_ip" {
  value = module.vm.public_ip
}

output "subnet_id" {
  value = module.network.subnet_id
}
