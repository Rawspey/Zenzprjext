variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_db_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the SQL Server."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "The environment tag for the resources."
  type        = string
}
