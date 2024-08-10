output "resource_group_name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.zenpayrg.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = var.location
}