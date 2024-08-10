output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.zenpay_vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.zenpay_vnet.name
}

output "vnet_address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.zenpay_vnet.address_space
}
