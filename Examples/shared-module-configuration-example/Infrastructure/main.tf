module "shared_configuration" {
  source = "./SharedConfigurationModule"
}

module "Module1" {
  source               = "./Module1"
  shared_configuration = module.shared_configuration.shared_configuration
  specific_configuration = {
    key1 = "modulevalue1"
  }
}

module "Module2" {
  source               = "./Module2"
  shared_configuration = module.shared_configuration.shared_configuration
  specific_configuration = {
    key2 = "modulevalue2"
  }
}
