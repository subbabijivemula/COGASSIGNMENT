# Root Variables

variable "business_unit" {
  description = "Business unit or application name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "prj_code" {
  description = "Project code for globally unique resources (Key Vault, Storage Account, etc.)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group - uses standardized naming convention"
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to deploy for scalability"
  type        = number

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 100
    error_message = "VM count must be between 1 and 100 for optimal performance."
  }
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "enable_public_ip" {
  description = "Enable public IP for VMs"
  type        = bool
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "patch_start_time" {
  description = "Start time for patch deployment (ISO 8601 format)"
  type        = string
}

variable "patch_days" {
  description = "Days of the week for patching"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

# Data Disk Configuration
variable "enable_data_disks" {
  description = "Enable data disk creation"
  type        = bool
}

variable "data_disks" {
  description = "List of data disks to attach to each VM"
  type = list(object({
    name                 = string
    size_gb              = number
    storage_account_type = string
    caching              = string
    lun                  = number
  }))
}

# Compute Module Variables
variable "ip_configuration_name" {
  description = "Name of the IP configuration"
  type        = string
}

variable "private_ip_allocation" {
  description = "Private IP address allocation method"
  type        = string
}

variable "disable_password_authentication" {
  description = "Disable password authentication for the VM"
  type        = bool
}

variable "os_disk_caching" {
  description = "Caching type for the OS disk"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
}

variable "vm_image_publisher" {
  description = "Publisher of the VM image"
  type        = string
}

variable "vm_image_offer" {
  description = "Offer of the VM image"
  type        = string
}

variable "vm_image_sku" {
  description = "SKU of the VM image"
  type        = string
}

variable "vm_image_version" {
  description = "Version of the VM image"
  type        = string
}

# Automation Module Variables
variable "log_analytics_sku" {
  description = "SKU for the Log Analytics workspace"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Retention period in days for Log Analytics workspace"
  type        = number
}

variable "automation_account_sku" {
  description = "SKU for the Automation Account"
  type        = string
}

variable "update_solution_name" {
  description = "Name of the update management solution"
  type        = string
}

variable "update_solution_publisher" {
  description = "Publisher of the update management solution"
  type        = string
}

variable "update_solution_product" {
  description = "Product name of the update management solution"
  type        = string
}

variable "schedule_frequency" {
  description = "Frequency of the patch schedule"
  type        = string
}

variable "schedule_interval" {
  description = "Interval for the patch schedule"
  type        = number
}

variable "schedule_description" {
  description = "Description for the patch schedule"
  type        = string
}

variable "tag_filter" {
  description = "Tag filter for targeting VMs"
  type        = string
}

variable "linux_classifications" {
  description = "Linux update classifications to include"
  type        = list(string)
}

variable "linux_excluded_packages" {
  description = "Linux packages to exclude from updates"
  type        = list(string)
}

variable "linux_included_packages" {
  description = "Linux packages to include in updates"
  type        = list(string)
}

variable "linux_reboot_setting" {
  description = "Reboot setting for Linux updates"
  type        = string
}

variable "schedule_name" {
  description = "Name of the patch schedule"
  type        = string
}

variable "update_config_name" {
  description = "Name of the update configuration"
  type        = string
}

variable "timezone" {
  description = "Timezone for the schedule"
  type        = string
}

# Networking Module Variables
variable "public_ip_allocation_method" {
  description = "Allocation method for the public IP"
  type        = string
}

variable "public_ip_sku" {
  description = "SKU for the public IP"
  type        = string
}

# Security Module Variables
variable "security_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

# Key Vault Module Variables
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

variable "keyvault_secrets" {
  description = "Map of additional secrets to store in Key Vault"
  type        = map(string)
  default     = {}
}

# Custom Script Extension Variables
variable "enable_custom_script_extension" {
  description = "Enable Custom Script Extension for VM configuration"
  type        = bool
  default     = false
}

variable "script_storage_account_name" {
  description = "Storage account name containing the setup script"
  type        = string
  default     = ""
}

variable "script_container_name" {
  description = "Container name containing the setup script"
  type        = string
  default     = ""
}

variable "script_name" {
  description = "Name of the setup script file"
  type        = string
  default     = ""
}

variable "script_url" {
  description = "Full URL to the setup script in storage account"
  type        = string
  default     = ""
}
