# Outputs for Automation Module
output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.id
}

output "automation_account_id" {
  description = "ID of the Automation Account"
  value       = azurerm_automation_account.aa.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.name
}

output "automation_account_name" {
  description = "Name of the Automation Account"
  value       = azurerm_automation_account.aa.name
}

output "patch_schedule_name" {
  description = "Name of the patch schedule"
  value       = azurerm_automation_schedule.weekly.name
}

output "oms_extensions_count" {
  description = "Number of VMs with OMS agent installed"
  value       = length(azurerm_virtual_machine_extension.oms)
}

output "workspace_id" {
  description = "Log Analytics workspace ID for VM connection"
  value       = azurerm_log_analytics_workspace.law.workspace_id
}
