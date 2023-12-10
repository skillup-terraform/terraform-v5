resource "azurerm_resource_group" "terra_rg" {
  location = var.location
  name = var.resource_group_name
  tags = var.resource_tags
}   

resource "azurerm_subnet" "name" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.terra_rg.name
  virtual_network_name = azurerm_virtual_network.terra_vm_network.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_virtual_network" "terra_vm_network" {
  name = var.virtual_network_name
  resource_group_name = azurerm_resource_group.terra_rg.name
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.terra_rg.location
}

resource "azurerm_network_interface" "name" {
  name = var.network_interface_name
    location             = var.location
  resource_group_name  = var.resource_group_name
  ip_configuration {
    name = "interal"
    subnet_id = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "terra-nsg" {
  name = var.network_sg_name
  location             = azurerm_resource_group.terra_rg.location
  resource_group_name  = azurerm_resource_group.terra_rg.name
  security_rule {
    name = "inbound-1"
    description = "test"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    access = "Allow"
    priority = 100
    direction = "Inbound"
  }

}

resource "azurerm_network_interface_security_group_association" "name" {
  network_interface_id = azurerm_network_interface.name.id
  network_security_group_id = azurerm_network_security_group.terra-nsg.id
}

