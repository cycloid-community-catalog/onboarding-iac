output "id" {
  value = data.azurerm_resource_group.resource_group.id
}

output "name" {
  value = var.name
}

output "location" {
  value = var.azure_location
}