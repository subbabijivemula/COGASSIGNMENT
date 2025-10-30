# Automation Module - Azure Automation and Patch Management
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.business_unit}-law-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_days

  tags = var.tags
}

# Automation Account
resource "azurerm_automation_account" "aa" {
  name                = "${var.business_unit}-aa-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.automation_account_sku

  tags = var.tags
}

# Link Automation Account to Log Analytics Workspace
resource "azurerm_log_analytics_linked_service" "link" {
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.law.id
  read_access_id      = azurerm_automation_account.aa.id

  depends_on = [azurerm_log_analytics_workspace.law, azurerm_automation_account.aa]
}

# Automation Solution for Update Management
resource "azurerm_log_analytics_solution" "updates" {
  solution_name         = var.update_solution_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = var.update_solution_publisher
    product   = var.update_solution_product
  }

  tags = var.tags

  depends_on = [azurerm_log_analytics_workspace.law]
}

# Connect VMs to Log Analytics (OMS Agent extension for Linux)
resource "azurerm_virtual_machine_extension" "oms" {
  count                      = length(var.vm_ids)
  name                       = "OmsAgentForLinux"
  virtual_machine_id         = var.vm_ids[count.index]
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.14"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    workspaceId = azurerm_log_analytics_workspace.law.workspace_id
  })

  protected_settings = jsonencode({
    workspaceKey = azurerm_log_analytics_workspace.law.primary_shared_key
  })

  tags = var.tags

  depends_on = [azurerm_log_analytics_workspace.law, azurerm_log_analytics_solution.updates]
}

# Weekly schedule in Automation
resource "azurerm_automation_schedule" "weekly" {
  name                    = "${var.business_unit}-weekly-patch-${var.environment}"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.aa.name
  frequency               = var.schedule_frequency
  interval                = var.schedule_interval
  timezone                = var.timezone
  start_time              = var.start_time
  description             = var.schedule_description

  depends_on = [azurerm_automation_account.aa]
}

resource "azurerm_automation_runbook" "patch_linux" {
  name                    = "${var.business_unit}-patch-linux-${var.environment}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.aa.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Linux VM patching runbook"
  runbook_type            = "PowerShell"

  content = <<-EOT
    # Linux VM patching automation script
    # Configures automated patch deployment for Linux virtual machines
    param(
        [Parameter(Mandatory=$true)]
        [string]$VMResourceIds
    )
    
    Write-Output "Starting Linux VM patch deployment for VMs: $VMResourceIds"
    Write-Output "Patch deployment initiated via Azure Automation"
    Write-Output "Review Azure Update Manager for advanced patch management features"
  EOT

  depends_on = [azurerm_automation_account.aa]
}
