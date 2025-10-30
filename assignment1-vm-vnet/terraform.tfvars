# Terraform Variables Configuration - Standardized Naming
business_unit = "webapp"
environment   = "dev"
location      = "East US"

# Unique identifier for globally unique resources (Key Vault, Storage Account, etc.)
prj_code = "cog25"

# Scalability Configuration
vm_count         = 1 # Change to 2, 3, 5, etc. for horizontal scaling
vm_size          = "Standard_B2s"
admin_username   = "azureuser"
enable_public_ip = true # Set to false to disable public IPs for all VMs

# VM Configuration
ip_configuration_name           = "internal"
private_ip_allocation           = "Dynamic"
disable_password_authentication = true
os_disk_caching                 = "ReadWrite"
os_disk_storage_account_type    = "Premium_LRS"
vm_image_publisher              = "Canonical"
vm_image_offer                  = "0001-com-ubuntu-server-jammy"
vm_image_sku                    = "22_04-lts-gen2"
vm_image_version                = "latest"

# Data Disk Configuration (Optional)
enable_data_disks = true # Set to true to enable data disks
data_disks = [
  {
    name                 = "data01"
    size_gb              = 128
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    lun                  = 0
  }
]

# Network Configuration
vnet_address_space          = ["10.0.0.0/16"]
subnet_address_prefixes     = ["10.0.1.0/24"]
public_ip_allocation_method = "Static"
public_ip_sku               = "Standard"

# Security Configuration
security_rules = [
  {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Automation Configuration
log_analytics_sku            = "PerGB2018"
log_analytics_retention_days = 30
automation_account_sku       = "Basic"
update_solution_name         = "Updates"
update_solution_publisher    = "Microsoft"
update_solution_product      = "OMSGallery/Updates"
schedule_frequency           = "Week"
schedule_interval            = 1
schedule_description         = "Weekly patch deployment schedule"
tag_filter                   = "Any"
linux_classifications        = ["Critical", "Security", "Other"]
linux_excluded_packages      = []
linux_included_packages      = []
linux_reboot_setting         = "IfRequired"
schedule_name                = "weekly-patch-schedule"
update_config_name           = "weekly-updates"
timezone                     = "Etc/UTC"

# Patch Management Configuration
patch_start_time = "2025-11-03T02:00:00Z" # Next Sunday at 2 AM UTC
patch_days       = ["Sunday"]

# Custom Script Extension Configuration
enable_custom_script_extension = true
script_storage_account_name     = "saterraformbe01"
script_container_name           = "scripts"
script_name                     = "nginx-setup.sh"
script_url                      = "https://saterraformbe01.blob.core.windows.net/scripts/nginx-setup.sh"

# Tags
tags = {
  Environment = "Demo"
  Project     = "Terraform"
}

# Key Vault Configuration
key_vault_sku               = "standard"
soft_delete_retention_days  = 7
purge_protection_enabled    = false
network_acls_default_action = "Allow"
network_acls_bypass         = "AzureServices"

# Additional secrets to store (can be used for VM, DB, etc.)
keyvault_secrets = {
  "admin-username"  = "azureuser"
  "ssh-private-key" = "" # Will be populated dynamically
  "ssh-public-key"  = "" # Will be populated dynamically
}
