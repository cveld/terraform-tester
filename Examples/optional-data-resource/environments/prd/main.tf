module "infrastructure" {
  source         = "../../infrastructure"
  resource_group = azurerm_resource_group.example
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "westeurope"
}
