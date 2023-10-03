#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the instance"
  value       = azurerm_linux_virtual_machine.webapp.public_ip_address
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = "admin"
}