# Create webapp VM
resource "azurerm_linux_virtual_machine" "webapp" {
  name                  = "${var.customer}-${var.project}-${var.env}-webapp"
  computer_name         = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_group_name   = data.azurerm_resource_group.webapp.name
  location              = var.azure_location
  network_interface_ids = [azurerm_network_interface.webapp.id]
  size                  = var.vm_instance_type

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
      publisher = "Debian"
      offer     = "debian-11"
      sku       = "11"
      version   = "latest"
  }

  disable_password_authentication = true

  custom_data = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      git_app_url = var.git_app_url
    }
  ))

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-webapp"
    role = "webapp"
  })
}