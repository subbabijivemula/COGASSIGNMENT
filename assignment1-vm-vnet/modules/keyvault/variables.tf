# Variables for Key Vault Module
variable "business_unit" {
  description = "Business unit or application name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "prj_code" {
  description = "Project code for globally unique resources"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "key_vault_sku" {
  description = "SKU for the Key Vault (standard or premium)"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Number of days that items should be retained for after soft-deletion"
  type        = number
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
}

variable "network_acls_default_action" {
  description = "Default action for network access rules"
  type        = string
}

variable "network_acls_bypass" {
  description = "Bypass network ACLs for Azure services"
  type        = string
}

variable "secrets" {
  description = "Map of additional secrets to store (key = secret name, value = secret value)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
