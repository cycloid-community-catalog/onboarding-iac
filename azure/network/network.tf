resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.customer}-${var.project}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.azure_location
  address_space       = [var.network_cidr]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "virtual_network"
  })
}

resource "azurerm_subnet" "private" {
  name                 = "${var.customer}-${var.project}-${var.env}-private"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.private_subnet_cidr]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "subnet"
    Tier = "Private"
  })
}

resource "azurerm_subnet" "public" {
  name                 = "${var.customer}-${var.project}-${var.env}-public"
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.public_subnet_cidr]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}"
    role = "subnet"
    Tier = "Public"
  })
}