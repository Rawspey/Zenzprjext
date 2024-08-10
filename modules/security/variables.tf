variable "location" {
  description = "The location where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_id" {
  description = "The ID of the resource group."
  type        = string
}

variable "contact_email" {
  description = "The email address for security contact."
  type        = string
}

variable "contact_phone" {
  description = "The phone number for security contact."
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
  default     = "security-posture-log-analytics"
}

variable "retention_in_days" {
  description = "The number of days to retain log data in the Log Analytics Workspace."
  type        = number
  default     = 30
}
