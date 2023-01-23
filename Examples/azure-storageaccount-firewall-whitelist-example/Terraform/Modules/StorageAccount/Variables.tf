variable "default_kv_id" {}
variable "global_settings" {}
variable "kv_ids" {}
variable "resource_group_key" { default = "" }
variable "storage_account_key" {}
variable "storage_account_value" {}
variable "subnet_ids" {}
variable "subnet_id" { default = "" }
locals {
  clientcode          = lookup(var.global_settings, "clientcode", null)
  solutionname        = lookup(var.global_settings, "solutionname", null)
  regioncode          = lookup(var.global_settings, "regioncode", null)
  environment         = lookup(var.global_settings, "environment", null)
  instancenumber      = lookup(var.global_settings, "instancenumber", 1)
  prefix              = lookup(var.global_settings, "prefix", true)
}
