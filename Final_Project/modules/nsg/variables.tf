variable "nsg_name" {
  type        = string
  description = "The name of the Network Security Group (NSG) to create or manage."
}

variable "location" {
  type        = string
  description = "The Azure region where the Network Security Group will be created, e.g., eastus or westus2."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Network Security Group will be created."
}
