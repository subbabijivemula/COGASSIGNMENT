# Root Module Outputs - Scalable Configuration
output "public_ip_address" {
  description = "Public IP address of the first VM (backwards compatibility)"
  value       = module.networking.public_ip_address
}

output "public_ip_addresses" {
  description = "Public IP addresses of all VMs"
  value       = module.networking.public_ip_addresses
}

output "web_url" {
  description = "URL to access the first web server (backwards compatibility)"
  value       = module.networking.public_ip_address != null ? "http://${module.networking.public_ip_address}" : "No public IP assigned"
}

output "web_urls" {
  description = "URLs to access all web servers"
  value       = [for ip in module.networking.public_ip_addresses : "http://${ip}"]
}

output "vm_names" {
  description = "Names of all virtual machines"
  value       = module.compute.vm_names
}

output "vm_private_ips" {
  description = "Private IP addresses of all VMs"
  value       = module.compute.vm_private_ips
}

output "vm_count" {
  description = "Number of VMs deployed"
  value       = var.vm_count
}

# Backwards compatibility for single VM
output "vm_name" {
  description = "Name of the first virtual machine (backwards compatibility)"
  value       = module.compute.vm_name
}

output "vm_private_ip" {
  description = "Private IP address of the first VM (backwards compatibility)"
  value       = module.compute.vm_private_ip
}

output "ssh_private_key" {
  description = "SSH private key for VM access"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "ssh_command" {
  description = "SSH command to connect to the first VM"
  value       = "ssh -i ssh_key.pem ${var.admin_username}@${module.networking.public_ip_address}"
}

output "scaling_info" {
  description = "Information about the current scaling configuration"
  value = {
    vm_count = var.vm_count
    vm_size  = var.vm_size
    region   = var.location
  }
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = module.automation.log_analytics_workspace_name
}

output "automation_account_name" {
  description = "Name of the Automation Account"
  value       = module.automation.automation_account_name
}

# Data Disk Outputs
output "data_disk_info" {
  description = "Information about data disks"
  value       = module.compute.data_disk_info
}

output "data_disk_names" {
  description = "Names of all data disks"
  value       = module.compute.data_disk_names
}

# Key Vault Outputs
output "key_vault_name" {
  description = "Name of the Key Vault containing VM secrets"
  value       = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.keyvault.key_vault_uri
}

output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = module.keyvault.key_vault_id
}

output "secrets_stored" {
  description = "List of secrets stored in Key Vault"
  value       = module.keyvault.secret_names
}

output "secret_ids" {
  description = "Map of secret names to their IDs"
  value       = module.keyvault.secret_ids
  sensitive   = true
}

output "ssh_connection_from_keyvault" {
  description = "How to connect to VMs using Key Vault secrets"
  value       = "Use: az keyvault secret show --vault-name ${module.keyvault.key_vault_name} --name ssh-private-key --query value -o tsv"
}
