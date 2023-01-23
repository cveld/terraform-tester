locals {
  shared_configuration = {
    key1 = "defaultvalue1"
    key2 = "defaultvalue2"
  }
}

module "Module1" {
  source               = "./Module1"
  shared_configuration = local.shared_configuration
  specific_configuration = {
    key1 = "module1value1"
  }
}

module "Module2" {
  source               = "./Module2"
  shared_configuration = local.shared_configuration
  specific_configuration = {
    key2 = "module2value2"
  }
}
