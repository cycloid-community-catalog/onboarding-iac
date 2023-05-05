#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = data.azurerm_resource_group.webapp.name
}

#
# vNet outputs
#
output "vnet_name" {
  description = "The name for the virtual network"
  value       = azurerm_virtual_network.webapp.name
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the EC2 instance"
  value       = azurerm_linux_virtual_machine.webapp.public_ip_address
}