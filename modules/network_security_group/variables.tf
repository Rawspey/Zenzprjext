variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "The location where the NSG will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the NSG will be created"
  type        = string
}

variable "security_rules" {
  description = "A list of security rules to apply to the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}
