# Variables for Networking Module
variable "business_unit" {
  description = "Business unit or application name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs for public IP allocation"
  type        = number
}

variable "enable_public_ip" {
  description = "Enable public IP for VMs"
  type        = bool
}

variable "public_ip_allocation_method" {
  description = "Allocation method for the public IP"
  type        = string
}

variable "public_ip_sku" {
  description = "SKU for the public IP"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
