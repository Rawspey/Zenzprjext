output "public_ip_id" {
  description = "The ID of the public IP address"
  value      = azurerm_public_ip.web_lb_pip.id
}

output "load_balancer_id" {
  description = "The ID of the load balancer"
  value      = azurerm_lb.web_lb.id
}

output "backend_pool_id" {
  description = "The ID of the load balancer backend address pool"
  value      = azurerm_lb_backend_address_pool.web_lb_backend.id
}

output "probe_id" {
  description = "The ID of the load balancer probe"
  value      = azurerm_lb_probe.web_lb_probe.id
}

output "lb_rule_id" {
  description = "The ID of the load balancer rule"
  value      = azurerm_lb_rule.web_lb_rule.id
}
