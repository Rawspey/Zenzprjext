resource "azurerm_key_vault" "zenpay_key_vault" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]
  }
}

resource "azurerm_recovery_services_vault" "zenpay_recovery_vault" {
  name                = var.recovery_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  name                = var.backup_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.zenpay_recovery_vault.name
  timezone            = var.timezone

  backup {
    frequency = var.backup_frequency
    time      = var.backup_time
  }

  retention_daily {
    count = var.retention_daily_count
  }

  retention_weekly {
    count    = var.retention_weekly_count
    weekdays = var.retention_weekly_days
  }

  retention_monthly {
    count    = var.retention_monthly_count
    weekdays = var.retention_monthly_days
    weeks    = var.retention_monthly_weeks
  }
}
