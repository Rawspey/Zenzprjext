resource "azurerm_public_ip" "web_lb_pip" {
  name                = "web-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "web_lb" {
  name                = "web-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "web-lb-frontend"
    public_ip_address_id = azurerm_public_ip.web_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web_lb_backend" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "web-lb-backend"
}

resource "azurerm_lb_probe" "web_lb_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "http-probe"
  protocol        = "Http"
  port            = 80
  request_path    = "/"
  interval_in_seconds = 15
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "web_lb_rule" {
  loadbalancer_id            = azurerm_lb.web_lb.id
  name                       = "http-rule"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.web_lb_backend.id]
  probe_id                       = azurerm_lb_probe.web_lb_probe.id
}