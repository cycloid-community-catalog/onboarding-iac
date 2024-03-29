resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.azure_location
  address_space       = [var.network_cidr]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "virtual_network"
  })

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "${var.customer}-${var.project}-${var.env}-private"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.private_subnet_cidr]
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.public_subnet_cidr]
}