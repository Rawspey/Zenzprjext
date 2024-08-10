output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace created for security posture."
  value       = azurerm_log_analytics_workspace.securitypostlog.id
}

output "security_contact_email" {
  description = "The email address of the security contact."
  value       = azurerm_security_center_contact.security_contact.email
}
