output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.web.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.web.name
}

output "address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.web.address_prefixes
}
