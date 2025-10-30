# Outputs for Compute Module
output "vm_ids" {
  description = "List of VM IDs"
  value       = [for vm in azurerm_linux_virtual_machine.vm : vm.id]
}

output "vm_names" {
  description = "List of VM names"
  value       = [for vm in azurerm_linux_virtual_machine.vm : vm.name]
}

output "vm_private_ips" {
  description = "List of private IP addresses"
  value       = [for nic in azurerm_network_interface.nic : nic.private_ip_address]
}

# Backwards compatibility outputs
output "vm_id" {
  description = "ID of the first VM (backwards compatibility)"
  value       = length(azurerm_linux_virtual_machine.vm) > 0 ? azurerm_linux_virtual_machine.vm[0].id : null
}

output "vm_name" {
  description = "Name of the first VM (backwards compatibility)"
  value       = length(azurerm_linux_virtual_machine.vm) > 0 ? azurerm_linux_virtual_machine.vm[0].name : null
}

output "vm_private_ip" {
  description = "Private IP of the first VM (backwards compatibility)"
  value       = length(azurerm_network_interface.nic) > 0 ? azurerm_network_interface.nic[0].private_ip_address : null
}

# Data Disk Outputs
output "data_disk_info" {
  description = "Information about data disks"
  value = var.enable_data_disks ? {
    total_disks = length(azurerm_managed_disk.disk)
    disks_per_vm = length(var.data_disks)
    vm_count = var.vm_count
  } : null
}

output "data_disk_names" {
  description = "Names of all data disks"
  value       = var.enable_data_disks ? [for disk in azurerm_managed_disk.disk : disk.name] : []
}
