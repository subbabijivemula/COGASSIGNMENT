# Variables for Compute Module
variable "business_unit" {
  description = "Business unit or application name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to deploy"
  type        = number
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "public_ip_id" {
  description = "ID of the public IP (for single VM)"
  type        = string
  default     = null
}

variable "public_ip_ids" {
  description = "List of public IP IDs (for multiple VMs)"
  type        = list(string)
  default     = []
}

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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

# Data Disk Variables
variable "enable_data_disks" {
  description = "Enable data disk creation"
  type        = bool
  default     = false
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
  default = []
}

# Key Vault Integration Variables
variable "use_keyvault_ssh" {
  description = "Use SSH key from Key Vault"
  type        = bool
  default     = false
}

variable "ssh_public_key_from_kv" {
  description = "SSH public key from Key Vault"
  type        = string
  default     = ""
}

variable "admin_username_from_kv" {
  description = "Admin username from Key Vault"
  type        = string
  default     = ""
}

# Custom Script Extension Variables
variable "enable_custom_script_extension" {
  description = "Enable Custom Script Extension for VM configuration"
  type        = bool
  default     = false
}

variable "script_url" {
  description = "Full URL to the setup script in storage account"
  type        = string
  default     = ""
}

variable "script_name" {
  description = "Name of the setup script file"
  type        = string
  default     = ""
}
