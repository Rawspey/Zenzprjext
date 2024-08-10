output "appgw_public_ip_id" {
  value = azurerm_public_ip.appgw_pip.id
}

output "appgw_id" {
  value = azurerm_application_gateway.zenpay_appgw.id
}
