variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine to create."
}

variable "location" {
  type        = string
  description = "The Azure region where the Virtual Machine will be deployed, e.g., eastus or westus2."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Virtual Machine will be created."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the Virtual Machine's network interface will be attached."
}

variable "nsg_id" {
  type        = string
  description = "The ID of the Network Security Group (NSG) to associate with the Virtual Machine's network interface."
}

variable "vm_size" {
  type        = string
  description = "The size (SKU) of the Virtual Machine, e.g., Standard_B1s or Standard_D2s_v3."
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the Virtual Machine."
}

variable "admin_password" {
  type        = string
  description = "The administrator password for the Virtual Machine. Marked as sensitive for security."
  sensitive   = true
}
