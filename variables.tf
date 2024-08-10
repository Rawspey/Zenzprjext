variable "resource_group_name" {
  description = "The name of the resource group for the zenpay network"
  type        = string
}
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "web_subnet_id" {
  description = "The ID of the subnet for web network interfaces"
  type        = string
}

variable "db_subnet_id" {
  description = "The ID of the subnet for the database network interface"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machines"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machines"
  type        = string
}
variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
  default     = "zenpaysqlserver"
}

variable "sql_db_name" {
  description = "The name of the SQL Database."
  type        = string
  default     = "zenpaysqldb"
}

variable "environment" {
  description = "The environment tag for the resources."
  type        = string
  default     = "Production"
}
variable "contact_email" {
  description = "The email address for security contact."
  type        = string
}

variable "contact_phone" {
  description = "The phone number for security contact."
  type        = string
}
