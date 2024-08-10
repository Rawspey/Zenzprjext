resource "azurerm_security_center_contact" "security_contact" {
  email               = var.contact_email
  phone               = var.contact_phone
  alert_notifications = true
  alerts_to_admins    = true
}

resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  auto_provision = "On"
}

resource "azurerm_log_analytics_workspace" "securitypostlog" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
}

resource "azurerm_security_center_workspace" "securityposturews" {
  scope        = var.resource_group_id
  workspace_id = azurerm_log_analytics_workspace.securitypostlog.id
}