# Key Vault Module
data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                       = "${var.business_unit}-kv-${var.environment}-${var.prj_code}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.key_vault_sku
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Access policy for current user/service principal
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]

    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore"
    ]
  }

  # Network access configuration
  network_acls {
    default_action = var.network_acls_default_action
    bypass         = var.network_acls_bypass
  }

  tags = var.tags
}

# Store dynamic secrets (can be used for any purpose - VM, DB, etc.)
resource "azurerm_key_vault_secret" "dynamic_secrets" {
  for_each     = var.secrets
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id

  tags = var.tags

  depends_on = [azurerm_key_vault.kv]
}
