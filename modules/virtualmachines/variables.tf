variable "web_nic_count" {
  description = "Number of web network interfaces to create"
  type        = number
}

variable "web_vm_count" {
  description = "Number of web virtual machines to create"
  type        = number
}

variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created"
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
