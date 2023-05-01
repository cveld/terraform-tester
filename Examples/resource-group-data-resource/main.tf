resource "azurerm_resource_group" "shared" {
  name     = "shared"
  location = "westeurope"
}

module "test" {
  source = "./Module1"
  name   = azurerm_resource_group.shared.name
}
