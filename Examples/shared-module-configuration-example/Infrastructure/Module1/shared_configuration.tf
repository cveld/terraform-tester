module "shared_configuration" {
  source                 = "../SharedConfigurationModule"
  shared_configuration   = var.shared_configuration
  specific_configuration = local.specific_configuration
}
