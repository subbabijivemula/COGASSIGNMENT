resource "azurerm_log_analytics_linked_service" "automation" {
  resource_group_name          = var.resource_group_name
  workspace_id                 = var.workspace_id
  linked_service_name          = "Automation"
  linked_service_properties_id = var.automation_account_id
}

# Weekly schedule for patch deployment (Sundays 2 AM)
resource "azurerm_automation_schedule" "weekly" {
  name                    = "WeeklyPatchSchedule"
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  frequency               = "Week"
  interval                = 1
  start_time              = "2025-11-02T02:00:00Z"
  timezone                = "UTC"
  description             = "Weekly patch deployment schedule"
}

# Update deployment configuration
resource "azurerm_automation_update_management" "patch_deploy" {
  automation_account_name = var.automation_account_name
  resource_group_name     = var.resource_group_name
  schedule_name           = azurerm_automation_schedule.weekly.name
  operating_system        = "Windows"

  targets {
    azure_query {
      scope {
        include = [var.vm_id]
      }
    }
  }

  duration = "PT2H"
}
