output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.zenpay_resource_group.resource_group_name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = module.zenpay_resource_group.resource_group_location
}
output "web_subnet_id" {
  value = module.web_subnet.subnet_id
}

output "db_subnet_id" {
  value = module.db_subnet.subnet_id
}

output "appgw_subnet_id" {
  value = module.appgw_subnet.subnet_id
}

output "web_subnet_name" {
  value = module.web_subnet.subnet_name
}

output "db_subnet_name" {
  value = module.db_subnet.subnet_name
}

output "appgw_subnet_name" {
  value = module.appgw_subnet.subnet_name
}

output "web_subnet_address_prefixes" {
  value = module.web_subnet.address_prefixes
}

output "db_subnet_address_prefixes" {
  value = module.db_subnet.address_prefixes
}

output "appgw_subnet_address_prefixes" {
  value = module.appgw_subnet.address_prefixes
}
output "web_nsg_id" {
  value = module.web_nsg.nsg_id
}

output "db_nsg_id" {
  value = module.db_nsg.nsg_id
}
output "web_nic_ids" {
  description = "The IDs of the web network interfaces"
  value       = module.virtualmachines.web_nic_ids
}

output "db_nic_id" {
  description = "The ID of the database network interface"
  value       = module.virtualmachines.db_nic_id
}

output "avset_id" {
  description = "The ID of the availability set"
  value       = module.virtualmachines.avset_id
}

output "web_vm_ids" {
  description = "The IDs of the web virtual machines"
  value       = module.virtualmachines.web_vm_ids
}

output "db_vm_id" {
  description = "The ID of the database virtual machine"
  value       = module.virtualmachines.db_vm_id
}
output "zenpay_vnet_id" {
  value = module.virtualnetwork.vnet_id
}

output "zenpay_vnet_name" {
  value = module.virtualnetwork.vnet_name
}
output "load_balancer_id" {
  description = "The ID of the load balancer"
  value      = module.loadbalancer.load_balancer_id
}

output "backend_pool_id" {
  description = "The ID of the load balancer backend address pool"
  value      = module.loadbalancer.backend_pool_id
}

output "probe_id" {
  description = "The ID of the load balancer probe"
  value      = module.loadbalancer.probe_id
}

output "lb_rule_id" {
  description = "The ID of the load balancer rule"
  value      = module.loadbalancer.lb_rule_id
}
output "appgw_public_ip_id" {
  value = module.applicationgateway.appgw_public_ip_id
}

output "appgw_id" {
  value = module.applicationgateway.appgw_id
}
output "sql_server_name" {
  description = "The name of the SQL Server."
  value       = module.sql.sql_server_name
}

output "sql_db_name" {
  description = "The name of the SQL Database."
  value       = module.sql.sql_db_name
}
output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace created for security posture."
  value       = module.security.log_analytics_workspace_id
}

output "security_contact_email" {
  description = "The email address of the security contact."
  value       = module.security.security_contact_email
}



