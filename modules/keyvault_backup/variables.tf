variable "key_vault_name" {
  description = "Name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "Location for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for Azure."
  type        = string
}

variable "object_id" {
  description = "Object ID for the Azure client."
  type        = string
}

variable "recovery_vault_name" {
  description = "Name of the Azure Recovery Services Vault."
  type        = string
}

variable "backup_policy_name" {
  description = "Name of the VM backup policy."
  type        = string
}

variable "timezone" {
  description = "Timezone for backup policy."
  type        = string
}

variable "backup_frequency" {
  description = "Frequency of the backup."
  type        = string
}

variable "backup_time" {
  description = "Time of the backup."
  type        = string
}

variable "retention_daily_count" {
  description = "Retention count for daily backups."
  type        = number
}

variable "retention_weekly_count" {
  description = "Retention count for weekly backups."
  type        = number
}

variable "retention_weekly_days" {
  description = "Days of the week for weekly backups."
  type        = list(string)
}

variable "retention_monthly_count" {
  description = "Retention count for monthly backups."
  type        = number
}

variable "retention_monthly_days" {
  description = "Days of the week for monthly backups."
  type        = list(string)
}

variable "retention_monthly_weeks" {
  description = "Weeks of the month for monthly backups."
  type        = list(string)
}
