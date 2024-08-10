provider "azurerm" {
  features {}
}

data "azurerm_client_config" "owner" {}

module "zenpay_resource_group" {
  source   = "./modules/resource-group"
  name     = "zenpayrg"
  location = "South Africa North"
}

module "virtualnetwork" {
  source              = "./modules/virtualnetwork"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "web_subnet" {
  source              = "./modules/subnet"
  subnet_name         = "web-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = module.virtualnetwork.vnet_name
  address_prefixes    = ["10.0.1.0/24"]
}

module "db_subnet" {
  source              = "./modules/subnet"
  subnet_name         = "db-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = module.virtualnetwork.vnet_name
  address_prefixes    = ["10.0.2.0/24"]
}

module "appgw_subnet" {
  source              = "./modules/subnet"
  subnet_name         = "appgw-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = module.virtualnetwork.vnet_name
  address_prefixes    = ["10.0.3.0/24"]
}
module "web_nsg" {
  source              = "./modules/network_security_group"
  nsg_name            = "web-nsg"
  location            = "southafricanorth"
  resource_group_name = var.resource_group_name
  security_rules = [
    {
      name                       = "allow-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
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
  ]
}

module "db_nsg" {
  source              = "./modules/network_security_group"
  nsg_name            = "db-nsg"
  location            = "southafricanorth"
  resource_group_name = var.resource_group_name
  security_rules = [
    {
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
  ]
}
module "virtualmachines" {
  source = "./modules/virtualmachines"

  web_nic_count          = 2
  web_vm_count           = 2
  location               = var.location
  resource_group_name    = var.resource_group_name
  web_subnet_id          = module.web_subnet.subnet_id
  db_subnet_id           = module.db_subnet.subnet_id
  admin_username         = var.admin_username
  admin_password         = var.admin_password
}
module "loadbalancer" {
  source              = "./modules/loadbalancer"
  location            = var.location
  resource_group_name = var.resource_group_name
}
module "applicationgateway" {
  source              = "./modules/applicationgateway"
  appgw_pip_name      = "appgw-pip"
  appgw_name          = "zenpay-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name
  appgw_capacity      = 2
  appgw_subnet_id     = module.appgw_subnet.subnet_id
}
module "sql" {
  source              = "./modules/sql"
  sql_server_name     = var.sql_server_name
  sql_db_name         = var.sql_db_name
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  environment         = var.environment
}
module "keyvault_backup" {
  source = "./modules/keyvault_backup"

  key_vault_name        = "zenpayzpkeyvault"
  location              = var.location
  resource_group_name   = var.resource_group_name
  tenant_id             = data.azurerm_client_config.owner.tenant_id
  object_id             = data.azurerm_client_config.owner.object_id
  recovery_vault_name   = "zenpayrecoveryvault"
  backup_policy_name    = "vm-backup-policy"
  timezone              = "UTC"
  backup_frequency      = "Daily"
  backup_time           = "23:00"
  retention_daily_count = 10
  retention_weekly_count = 42
  retention_weekly_days = ["Sunday", "Wednesday", "Friday", "Saturday"]
  retention_monthly_count = 7
  retention_monthly_days = ["Sunday", "Wednesday"]
  retention_monthly_weeks = ["First", "Last"]
}
module "security" {
  source              = "./modules/security"
  location            = var.location
  resource_group_name = var.resource_group_name
  resource_group_id   = module.zenpay_resource_group.resource_group_name
  contact_email       = var.contact_email
  contact_phone       = var.contact_phone
}