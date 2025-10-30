# Networking Module - Virtual Network and Subnet
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.business_unit}-vnet-${var.environment}"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Subnet
resource "azurerm_subnet" "snet" {
  name                 = "${var.business_unit}-subnet-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Public IP for the VMs - Scalable with count
resource "azurerm_public_ip" "pip" {
  count               = var.enable_public_ip ? var.vm_count : 0
  name                = var.vm_count > 1 ? "${var.business_unit}-pip-${var.environment}-${format("%02d", count.index + 1)}" : "${var.business_unit}-pip-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku

  tags = var.tags
}
