# Outputs for Networking Module
output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "ID of the Subnet"
  value       = azurerm_subnet.snet.id
}

output "subnet_name" {
  description = "Name of the Subnet"
  value       = azurerm_subnet.snet.name
}

output "public_ip_id" {
  description = "ID of the first public IP (for backwards compatibility)"
  value       = length(azurerm_public_ip.pip) > 0 ? azurerm_public_ip.pip[0].id : null
}

output "public_ip_address" {
  description = "Address of the first public IP (for backwards compatibility)"
  value       = length(azurerm_public_ip.pip) > 0 ? azurerm_public_ip.pip[0].ip_address : null
}

output "public_ip_ids" {
  description = "List of all public IP IDs"
  value       = [for pip in azurerm_public_ip.pip : pip.id]
}

output "public_ip_addresses" {
  description = "List of all public IP addresses"
  value       = [for pip in azurerm_public_ip.pip : pip.ip_address]
}
