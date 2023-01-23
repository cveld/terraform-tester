# Source code based on the following source:
# https://github.com/aztfmod/terraform-azurerm-caf/tree/main/modules/storage_account

resource "azurerm_storage_account" "storageaccount" {
  name = local.storage_account_name
  resource_group_name = local.resource_group_name
  location = local.resource_location
  #var.storage_account_key != "" ? var.storage_account_value.name : local.prefix ? join("", compact(["st", local.clientcode, local.solutionname, var.storage_account_key, local.regioncode, local.environment, format("%03d", local.instancenumber)])) : join("", compact([local.clientcode, local.solutionname, var.storage_account_key, local.regioncode, local.environment, format("%03d", local.instancenumber), "st"]))

  account_kind = lookup(var.storage_account_value, "account_kind", null)
  account_tier = var.storage_account_value["account_tier"]
  account_replication_type = var.storage_account_value["account_replication_type"]

  access_tier = lookup(var.storage_account_value, "access_tier", null)
  
  enable_https_traffic_only = true
  is_hns_enabled = lookup(var.storage_account_value, "is_hns_enabled", null)
  min_tls_version = "TLS1_2"
  nfsv3_enabled = lookup(var.storage_account_value, "nfsv3_enabled", null)

  dynamic "identity" {
    for_each = lookup(var.storage_account_value, "identity", {}) != {} ? [1] : []
    content {
      type = lookup(var.storage_account_value["identity"], "type", "SystemAssigned")
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.storage_account_value, "network_rules", null) != null ? [1] : []
    content {
      default_action             = lookup(var.storage_account_value.network_rules, "default_action", null)
      bypass                     = lookup(var.storage_account_value.network_rules, "bypass", null)
      ip_rules                   = lookup(var.storage_account_value.network_rules, "ip_rules", null)
      virtual_network_subnet_ids = try([for key in var.storage_account_value.network_rules.subnet_keys : var.subnet_ids[key]], null)
    }
  }

  tags = coalesce(lookup(var.storage_account_value, "tags", null), lookup(var.global_settings, "tags", null), null)
}

module "hns_filesystem" {
  source = "./hns-filesystem"
  depends_on = [
    azurerm_role_assignment.rw_permissions
  ]
  for_each = {
    for value in try(var.storage_account_value.hns_filesystems, []):
    value.name => value
  }
  hns_filesystem_name = each.key
  resource_group_name = local.resource_group_name
  storage_account = azurerm_storage_account.storageaccount
  hns_folders = try(each.value.hns_folders, [])
}

# The roles Owner and Contributor do not contain any data plane permissions.
# Data plane permissions are required for data plane operations, therefore we assign the role Storage Blob Data Contributor.
resource "azurerm_role_assignment" "rw_permissions" {
  depends_on = [
    azurerm_storage_account.storageaccount
  ]
  for_each = toset(try(var.storage_account_value.rw_permissions, []))
  scope                = azurerm_storage_account.storageaccount.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

