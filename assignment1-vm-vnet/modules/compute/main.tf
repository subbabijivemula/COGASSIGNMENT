# Compute Module - Scalable VM Deployment

# Local value to determine which SSH key to use
locals {
  ssh_public_key = var.use_keyvault_ssh ? var.ssh_public_key_from_kv : var.ssh_public_key
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Network Interface - Scalable with count
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.business_unit}-nic-${var.environment}-${format("%02d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = length(var.public_ip_ids) > count.index ? var.public_ip_ids[count.index] : null
  }

  tags = var.tags
}

# Virtual Machine - Scalable with count
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "${var.business_unit}-vm-${var.environment}-${format("%02d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.use_keyvault_ssh ? var.admin_username_from_kv : var.admin_username

  # Disable password authentication and use SSH keys
  disable_password_authentication = var.disable_password_authentication

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = var.use_keyvault_ssh ? var.admin_username_from_kv : var.admin_username
    public_key = local.ssh_public_key
  }

  os_disk {
    name                 = "${var.business_unit}-osdisk-${var.environment}-${format("%02d", count.index + 1)}"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  tags = var.tags
}

# Data Disks - Dynamic creation based on configuration
resource "azurerm_managed_disk" "disk" {
  count                = var.enable_data_disks ? var.vm_count * length(var.data_disks) : 0
  name                 = "${var.business_unit}-datadisk-${var.environment}-${format("%02d", floor(count.index / length(var.data_disks)) + 1)}-${var.data_disks[count.index % length(var.data_disks)].name}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disks[count.index % length(var.data_disks)].storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disks[count.index % length(var.data_disks)].size_gb

  tags = var.tags
}

# Data Disk Attachments
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  count              = var.enable_data_disks ? var.vm_count * length(var.data_disks) : 0
  managed_disk_id    = azurerm_managed_disk.disk[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[floor(count.index / length(var.data_disks))].id
  lun                = var.data_disks[count.index % length(var.data_disks)].lun
  caching            = var.data_disks[count.index % length(var.data_disks)].caching

  depends_on = [azurerm_managed_disk.disk, azurerm_linux_virtual_machine.vm]
}

# Custom Script Extension - Downloads and executes setup script from storage account
resource "azurerm_virtual_machine_extension" "custom_script" {
  count                = var.enable_custom_script_extension ? var.vm_count : 0
  name                 = "CustomScript"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode({
    fileUris = [var.script_url]
  })

  protected_settings = jsonencode({
    commandToExecute = "chmod +x ${var.script_name} && ./${var.script_name}"
  })

  tags = var.tags

  depends_on = [azurerm_linux_virtual_machine.vm]
}
