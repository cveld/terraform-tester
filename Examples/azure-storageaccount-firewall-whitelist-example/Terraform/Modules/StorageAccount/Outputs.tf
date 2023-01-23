output "storageaccount_id" {
  description = "storage account id"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].id
  #}
  value = azurerm_storage_account.storageaccount.id
}

output "storageaccount_name" {
  description = "storage account name"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].name
  #}
  value = azurerm_storage_account.storageaccount.name
}

output "storageaccount_primary_access_key" {
  description = "primary access key for the storage account"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].primary_access_key
  #}
  value = azurerm_storage_account.storageaccount.primary_access_key
}

output "storageaccount_secondary_access_key" {
  description = "secondary access key for the storage account"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].secondary_access_key
  #}
  value = azurerm_storage_account.storageaccount.secondary_access_key
}

output "storageaccount_primary_connection_string" {
  description = "primary connection string for the storage account"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].primary_connection_string
  #}
  value = azurerm_storage_account.storageaccount.primary_connection_string
}

output "storageaccount_secondary_connection_string" {
  description = "secondary connection string for the storage account"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].secondary_connection_string
  #}
  value = azurerm_storage_account.storageaccount.secondary_connection_string
}

output "storageaccount_primary_blob_endpoint" {
  description = "secondary connection string for the storage account"
  #value = {
  #  for storage_account in keys(azurerm_storage_account.storageaccount):
  #    storage_account => azurerm_storage_account.storageaccount[storage_account].secondary_connection_string
  #}
  value = azurerm_storage_account.storageaccount.primary_blob_endpoint
}
