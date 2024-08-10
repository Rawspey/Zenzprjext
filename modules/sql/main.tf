resource "azurerm_sql_server" "zenpaysqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  tags = {
    environment = var.environment
  }
}

resource "azurerm_sql_database" "zenpaysqldb" {
  name                           = var.sql_db_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  server_name                    = azurerm_sql_server.zenpaysqlserver.name
  edition                        = "Standard"
  requested_service_objective_name = "S0"
}

resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.zenpaysqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
