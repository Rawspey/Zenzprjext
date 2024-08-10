output "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.zenpay_key_vault.id
}

output "recovery_vault_id" {
  description = "The ID of the Recovery Services Vault."
  value       = azurerm_recovery_services_vault.zenpay_recovery_vault.id
}

output "backup_policy_id" {
  description = "The ID of the VM backup policy."
  value       = azurerm_backup_policy_vm.vm_backup_policy.id
}
