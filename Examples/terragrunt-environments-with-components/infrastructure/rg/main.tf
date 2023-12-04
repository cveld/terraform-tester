resource "azurerm_resource_group" "default" {
  name     = "test"
  location = "westeurope"
}

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}
