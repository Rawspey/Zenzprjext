resource "azurerm_public_ip" "appgw_pip" { 
  name                = var.appgw_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" 
  sku                 = "Standard" 
}

resource "azurerm_application_gateway" "zenpay_appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = var.appgw_capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-configuration"
    subnet_id = var.appgw_subnet_id
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = "appgw-backend-pool"
  }

  backend_http_settings {
    name                  = "appgw-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
  }

  http_listener {
    name                           = "appgw-http-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "appgw-http-port"
    protocol                       = "Http"
  }

  frontend_port {
    name = "appgw-http-port"
    port = 80
  }

  request_routing_rule {
    name                       = "appgw-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "appgw-http-listener"
    backend_address_pool_name  = "appgw-backend-pool"
    backend_http_settings_name = "appgw-backend-http-settings"
    priority                   = 1 
  }
}
