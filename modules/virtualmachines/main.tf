resource "azurerm_network_interface" "web_nic" {
  count               = var.web_nic_count
  name                = "webnic${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "webnic${count.index}-ip"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db_nic" {
  name                = "dbnic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dbnic-ip"
    subnet_id                     = var.db_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_availability_set" "avset" {
  name                = "web-avset"
  location            = var.location
  resource_group_name = var.resource_group_name

  platform_fault_domain_count   = 2
  platform_update_domain_count  = 5
}

resource "azurerm_virtual_machine" "web_vm" {
  count               = var.web_vm_count
  name                = "webvm${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    element(azurerm_network_interface.web_nic.*.id, count.index)
  ]
  availability_set_id = azurerm_availability_set.avset.id
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
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {}
}

resource "azurerm_virtual_machine" "db_vm" {
  name                = "dbvm"
  location            = var.location
  resource_group_name = var.resource_group_name
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
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {}
}
