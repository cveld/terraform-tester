resource "azurerm_key_vault" "default" {
  name                = "kvtest"
  location            = "westeurope"
  tenant_id           = data.azurerm_client_config.default.tenant_id
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
}

data "azurerm_client_config" "default" {

}
