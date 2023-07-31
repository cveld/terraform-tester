module "infrastructure" {
  source         = "../../infrastructure"
  resource_group = data.azurerm_resource_group.existing
}

data "azurerm_resource_group" "existing" {
  name = "rg-existing"
}
