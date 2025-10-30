variable "region" {
  description = "Azure region for resource deployment"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

# Networking
variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_prefixes" {
  description = "Subnet CIDR prefixes"
  type        = list(string)
}

# Network Security Group
variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
}

# Virtual Machine
variable "vm_name" {
  description = "Virtual machine name"
  type        = string
}

variable "vm_size" {
  description = "VM size (SKU)"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

# Patch Management
variable "patch_schedule_day" {
  description = "Day of the week for patch schedule"
  type        = string
}

variable "patch_schedule_time" {
  description = "Time of day for patch schedule"
  type        = string
}
