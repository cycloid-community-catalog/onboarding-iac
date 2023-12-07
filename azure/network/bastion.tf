resource "azurerm_public_ip" "public_ip" {
  name                = "${var.customer}-${var.project}-${var.env}"
  location            = var.azure_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${var.customer}-${var.project}-${var.env}"
  location            = var.azure_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.public_subnet.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}