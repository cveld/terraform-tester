data "azurerm_client_config" "current" {}

resource "null_resource" "add_ip_to_whitelist" {
  provisioner "local-exec" {
    command     = ". '${path.module}/../../../../../../../Scripts/Add-MyIpToWhitelist.ps1' -ResourceGroupName \"${var.resource_group_name}\" -StorageAccountName \"${var.storage_account.name}\" -SubscriptionId \"${data.azurerm_client_config.current.subscription_id}\""
    interpreter = ["pwsh", "-Command"]
  }

  triggers = {
    "hns_folders" = join(",", var.hns_folders)
  }
}

resource "azurerm_storage_data_lake_gen2_path" "hns_folders" {
  depends_on = [
    azurerm_storage_data_lake_gen2_filesystem.hns_filesystem, null_resource.add_ip_to_whitelist
  ]
  for_each = toset(var.hns_folders)
  path               = each.value
  filesystem_name    = var.hns_filesystem_name
  storage_account_id = var.storage_account.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "hns_filesystem" {
  name = var.hns_filesystem_name
  storage_account_id  = var.storage_account.id
}

resource "null_resource" "remove_ip_from_whitelist" {
  depends_on = [
     azurerm_storage_data_lake_gen2_path.hns_folders, null_resource.add_ip_to_whitelist
  ]
  provisioner "local-exec" {
    command     = ". '${path.module}/../../../../../../../Scripts/Remove-MyIpFromWhitelist.ps1' -ResourceGroupName \"${var.resource_group_name}\" -StorageAccountName \"${var.storage_account.name}\" -SubscriptionId \"${data.azurerm_client_config.current.subscription_id}\""
    interpreter = ["pwsh", "-Command"]
  }

  triggers = {
    "hns_folders" = join(",", var.hns_folders)
  }
}
