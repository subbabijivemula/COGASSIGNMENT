# Enable Update Management for a VM
resource "azurerm_automation_update_management" "this" {
  name                     = var.schedule_name
  resource_group_name      = var.automation_account_rg
  automation_account_name  = var.automation_account_name
  azure_virtual_machine_ids = [var.vm_id]
  operating_system         = "Windows"
  duration                 = "PT2H"
  reboot_setting           = "IfRequired"

  schedule {
    frequency = "Week"
    interval  = 1
    start_time = timeadd(timestamp(), "24h") # starts tomorrow
    time_zone  = "UTC"
  }

  non_azure_computer_names = []
  description              = "Weekly patch deployment"
}

