provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-patch-mgmt"
  location = "East US"
}

# Log Analytics
module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = "law-patch-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Automation Account
module "automation" {
  source              = "./modules/automation_account"
  name                = "autoacct-patch-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Existing VM reference (example)
data "azurerm_virtual_machine" "target_vm" {
  name                = "myVM"
  resource_group_name = "myVMResourceGroup"
}

# Update Management
module "update_management" {
  source                  = "./modules/update_management"
  resource_group_name     = azurerm_resource_group.rg.name
  workspace_id            = module.log_analytics.workspace_id
  automation_account_id   = module.automation.automation_account_id
  automation_account_name = module.automation.automation_account_name
  vm_id                   = data.azurerm_virtual_machine.target_vm.id
}
