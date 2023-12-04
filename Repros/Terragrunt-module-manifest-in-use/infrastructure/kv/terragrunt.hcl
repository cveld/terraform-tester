dependency "rg" {
    config_path = "${get_terragrunt_dir()}/../rg"
}

terraform {
  source = "../../../infrastructure/kv"
}

inputs = {
  resource_group_name = dependency.rg.outputs.resource_group_name
}
