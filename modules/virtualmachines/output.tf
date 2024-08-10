output "web_nic_ids" {
  description = "The IDs of the web network interfaces"
  value       = azurerm_network_interface.web_nic[*].id
}

output "db_nic_id" {
  description = "The ID of the database network interface"
  value       = azurerm_network_interface.db_nic.id
}

output "avset_id" {
  description = "The ID of the availability set"
  value       = azurerm_availability_set.avset.id
}

output "web_vm_ids" {
  description = "The IDs of the web virtual machines"
  value       = azurerm_virtual_machine.web_vm[*].id
}

output "db_vm_id" {
  description = "The ID of the database virtual machine"
  value       = azurerm_virtual_machine.db_vm.id
}
