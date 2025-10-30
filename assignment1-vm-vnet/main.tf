
# Generate SSH key pair for VM access
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.business_unit}-rg-${var.environment}"
  location = var.location

  tags = var.tags
}

# Key Vault Module - Store sensitive VM information (created first)
module "keyvault" {
  source = "./modules/keyvault"

  business_unit               = var.business_unit
  environment                 = var.environment
  prj_code                    = var.prj_code
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  key_vault_sku               = var.key_vault_sku
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  network_acls_default_action = var.network_acls_default_action
  network_acls_bypass         = var.network_acls_bypass

  # Dynamic secrets (SSH keys + additional secrets)
  secrets = merge(var.keyvault_secrets, {
    "ssh-private-key" = tls_private_key.ssh.private_key_pem
    "ssh-public-key"  = tls_private_key.ssh.public_key_openssh
  })

  tags = var.tags
}

# Data sources to read secrets from Key Vault
data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.keyvault]
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin-username"
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.keyvault]
}

# Networking Module
module "networking" {
  source = "./modules/networking"

  business_unit               = var.business_unit
  environment                 = var.environment
  address_space               = var.vnet_address_space
  subnet_address_prefixes     = var.subnet_address_prefixes
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  vm_count                    = var.vm_count
  enable_public_ip            = var.enable_public_ip
  public_ip_allocation_method = var.public_ip_allocation_method
  public_ip_sku               = var.public_ip_sku

  tags = var.tags
}

# Security Module
module "security" {
  source = "./modules/security"

  business_unit       = var.business_unit
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.networking.subnet_id
  security_rules      = var.security_rules

  tags = var.tags

  depends_on = [module.networking]
}

# Compute Module - Scalable VM Deployment
module "compute" {
  source = "./modules/compute"

  business_unit                   = var.business_unit
  environment                     = var.environment
  vm_count                        = var.vm_count
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  vm_size                         = var.vm_size
  admin_username                  = var.admin_username
  ssh_public_key                  = tls_private_key.ssh.public_key_openssh
  subnet_id                       = module.networking.subnet_id
  public_ip_id                    = module.networking.public_ip_id
  public_ip_ids                   = module.networking.public_ip_ids
  ip_configuration_name           = var.ip_configuration_name
  private_ip_allocation           = var.private_ip_allocation
  disable_password_authentication = var.disable_password_authentication
  os_disk_caching                 = var.os_disk_caching
  os_disk_storage_account_type    = var.os_disk_storage_account_type
  vm_image_publisher              = var.vm_image_publisher
  vm_image_offer                  = var.vm_image_offer
  vm_image_sku                    = var.vm_image_sku
  vm_image_version                = var.vm_image_version

  # Data Disk Configuration
  enable_data_disks = var.enable_data_disks
  data_disks        = var.data_disks

  # Key Vault Integration - Pass values from data sources
  use_keyvault_ssh       = true
  ssh_public_key_from_kv = data.azurerm_key_vault_secret.ssh_public_key.value
  admin_username_from_kv = data.azurerm_key_vault_secret.admin_username.value

  # Custom Script Extension Configuration
  enable_custom_script_extension = var.enable_custom_script_extension
  script_url                     = var.script_url
  script_name                    = var.script_name

  tags = var.tags

  depends_on = [module.networking, module.security, module.keyvault]
}

# Automation Module
module "automation" {
  source = "./modules/automation"

  business_unit                = var.business_unit
  environment                  = var.environment
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rg.name
  vm_name                      = module.compute.vm_name
  vm_ids                       = module.compute.vm_ids
  vm_resource_group_id         = azurerm_resource_group.rg.id
  start_time                   = var.patch_start_time
  patch_days                   = var.patch_days
  log_analytics_sku            = var.log_analytics_sku
  log_analytics_retention_days = var.log_analytics_retention_days
  automation_account_sku       = var.automation_account_sku
  update_solution_name         = var.update_solution_name
  update_solution_publisher    = var.update_solution_publisher
  update_solution_product      = var.update_solution_product
  schedule_frequency           = var.schedule_frequency
  schedule_interval            = var.schedule_interval
  schedule_description         = var.schedule_description
  tag_filter                   = var.tag_filter
  linux_classifications        = var.linux_classifications
  linux_excluded_packages      = var.linux_excluded_packages
  linux_included_packages      = var.linux_included_packages
  linux_reboot_setting         = var.linux_reboot_setting
  schedule_name                = var.schedule_name
  update_config_name           = var.update_config_name
  timezone                     = var.timezone

  tags = var.tags

  depends_on = [module.compute]
}

