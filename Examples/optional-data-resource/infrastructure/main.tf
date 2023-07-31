resource "azurerm_storage_account" "example" {
  name                     = "example"
  resource_group_name      = var.resource_group.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

