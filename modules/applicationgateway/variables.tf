variable "appgw_pip_name" {
  type        = string
  description = "The name of the public IP for Application Gateway."
}

variable "appgw_name" {
  type        = string
  description = "The name of the Application Gateway."
}

variable "location" {
  type        = string
  description = "The location where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "appgw_capacity" {
  type        = number
  description = "The capacity of the Application Gateway."
}

variable "appgw_subnet_id" {
  type        = string
  description = "The subnet ID for the Application Gateway."
}
