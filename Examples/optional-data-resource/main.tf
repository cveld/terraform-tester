data "azurerm_storage_account" "example" {
  name                = "example"
  resource_group_name = "example"
}

provider "azurerm" {
  features {}
}
  
