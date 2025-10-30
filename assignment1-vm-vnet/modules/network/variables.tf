variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network (VNet) to create or manage."
}

variable "vnet_cidr" {
  type        = string
  description = "The address space (CIDR block) for the Virtual Network, e.g., 10.0.0.0/16."
}

variable "subnet_name" {
  type        = string
  description = "The name of the Subnet within the Virtual Network."
}

variable "subnet_cidr" {
  type        = string
  description = "The address prefix (CIDR block) for the Subnet, e.g., 10.0.1.0/24."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be created, e.g., eastus or westus2."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing or new Resource Group that will contain the resources."
}
