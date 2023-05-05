# Create Network Security Group
resource "azurerm_network_security_group" "webapp" {
  name                = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_group_name = data.azurerm_resource_group.webapp.name
  location            = var.azure_location

  security_rule {
    name                       = "inbound-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "inbound-webapp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-webapp"
  })
}

# Get a Static Public IP
resource "azurerm_public_ip" "webapp" {
  name                = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_group_name = data.azurerm_resource_group.webapp.name
  location            = var.azure_location
  allocation_method   = "Dynamic"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-webapp"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "webapp" {
  name                = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_group_name = data.azurerm_resource_group.webapp.name
  location            = var.azure_location

  ip_configuration {
      name                          = "${var.customer}-${var.project}-${var.env}-webapp"
      subnet_id                     = azurerm_subnet.webapp.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.webapp.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-webapp"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "webapp" {
    network_interface_id      = azurerm_network_interface.webapp.id
    network_security_group_id = azurerm_network_security_group.webapp.id
}

resource "azurerm_virtual_network" "webapp" {
  name                = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_group_name = data.azurerm_resource_group.webapp.name
  location            = var.azure_location
  address_space       = ["10.222.0.0/16"]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-webapp"
  })
}

resource "azurerm_subnet" "webapp" {
  name                 = "${var.customer}-${var.project}-${var.env}-webapp"
  virtual_network_name = azurerm_virtual_network.webapp.name
  resource_group_name  = data.azurerm_resource_group.webapp.name

  address_prefixes     = ["10.222.1.0/24"]
}