provider "azurerm" {
  features {}
}

data "azurerm_client_config" "owner" {}

resource "azurerm_resource_group" "zenpayrg" {
  name     = "zenpayrg"
  location = " South Africa North"
}
resource "azurerm_virtual_network" "zenpayvnet" {
  name                = "zenpayvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  }
  resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.zenpayrg.name
  virtual_network_name = azurerm_virtual_network.zenpayvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.zenpayrg.name
  virtual_network_name = azurerm_virtual_network.zenpayvnet.name
  address_prefixes     = ["10.0.2.0/24"] 
  }
resource "azurerm_subnet" "appgw" { 
  name = "appgw-subnet" 
  resource_group_name = azurerm_resource_group.zenpayrg.name 
  virtual_network_name = azurerm_virtual_network.zenpayvnet.name 
  address_prefixes = ["10.0.3.0/24"] 
  }

  resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  security_rule {
    name                       = "allow-sql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "web_nic" {
  count               = 2
  name                = "webnic${count.index}"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  ip_configuration {
    name                          = "webnic${count.index}-ip"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "db_nic" {
  name                = "dbnic"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  ip_configuration {
    name                          = "dbnic-ip"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_availability_set" "web_avset" {
  name                = "web-avset"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  platform_fault_domain_count = 2
  platform_update_domain_count = 5
  }
  resource "azurerm_virtual_machine" "web_vm" {
  count               = 2
  name                = "webvm${count.index}"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  network_interface_ids = [
    element(azurerm_network_interface.web_nic.*.id, count.index)
  ]
  availability_set_id = azurerm_availability_set.web_avset.id
  vm_size             = "Standard_D2s_v3"

  storage_os_disk {
    name              = "web_os_disk${count.index}"
    caching           = "ReadWrite"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 128
    create_option     = "FromImage"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname${count.index}"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {}
}
resource "azurerm_virtual_machine" "db_vm" {
  name                = "dbvm"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  network_interface_ids = [
    azurerm_network_interface.db_nic.id
  ]
  vm_size             = "Standard_D4s_v3"

  storage_os_disk {
    name              = "db_os_disk"
    caching           = "ReadWrite"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
    create_option     = "FromImage"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname-db"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {}
}
resource "azurerm_public_ip" "web_lb_pip" {
  name                = "web-lb-pip"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "web_lb" {
  name                = "web-lb"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
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
resource "azurerm_public_ip" "appgw_pip" { 
    name = "appgw-pip" 
    location = azurerm_resource_group.zenpayrg.location 
    resource_group_name = azurerm_resource_group.zenpayrg.name 
    allocation_method = "Static" 
    sku = "Standard" 
    }

resource "azurerm_application_gateway" "zenpay-appgw" {
  name                = "zenpay-appgw"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-configuration"
    subnet_id = azurerm_subnet.appgw.id
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
    priority = 1 
  }
}

resource "azurerm_sql_server" "zenpaysqlserver" {
  name                         = "zenpaysqlserver"
  resource_group_name          = azurerm_resource_group.zenpayrg.name
  location                     = azurerm_resource_group.zenpayrg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "AdminPassword123!"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_sql_database" "zenpaysqldb" {
  name                = "zenpaysqldb"
  resource_group_name = azurerm_resource_group.zenpayrg.name
  location            = azurerm_resource_group.zenpayrg.location
  server_name         = azurerm_sql_server.zenpaysqlserver.name
  edition             = "Standard"
  requested_service_objective_name = "S0"
  
}

resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  resource_group_name = azurerm_resource_group.zenpayrg.name
  server_name         = azurerm_sql_server.zenpaysqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
resource "azurerm_key_vault" "zenpay_key_vault" {
  name                = "zenpayzpkeyvault"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.owner.tenant_id
  access_policy {
    tenant_id = data.azurerm_client_config.owner.tenant_id
    object_id = data.azurerm_client_config.owner.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]
  }
}
resource "azurerm_recovery_services_vault" "zenpay_recovery_vault" {
  name                = "zenpayrecoveryvault"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  sku                 = "Standard"
}
resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  name                =  "vm-backup-policy"
  resource_group_name = azurerm_resource_group.zenpayrg.name
  recovery_vault_name = azurerm_recovery_services_vault.zenpay_recovery_vault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }

  retention_weekly {
    count    = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }
   }

resource "azurerm_security_center_contact" "security_contact" {
  email               = "femirawlings@gmail.com"
  phone               = "+2348145727670"
  alert_notifications = true
  alerts_to_admins    = true
}


resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  auto_provision = "On"
}


resource "azurerm_log_analytics_workspace" "securitypostlog" {
  name                = "security-posture-log-analytics"
  location            = azurerm_resource_group.zenpayrg.location
  resource_group_name = azurerm_resource_group.zenpayrg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  }

resource "azurerm_security_center_workspace" "securityposturews" {
  scope                = azurerm_resource_group.zenpayrg.id
  workspace_id         = azurerm_log_analytics_workspace.securitypostlog.id
}