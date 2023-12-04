include "root" {
  path = find_in_parent_folders()
}

# Include the common configuration for the component. The common configuration contains settings that are common
# for the component across all environments.
include "common" {
  path   = "${dirname(find_in_parent_folders())}/infrastructure/${basename(get_terragrunt_dir())}/terragrunt.hcl"
  expose = true
}
