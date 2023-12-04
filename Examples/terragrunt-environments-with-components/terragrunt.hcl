locals {
  # Automatically load account-level variables
  #account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  #region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.41.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

terraform {
    backend "azurerm" {}
}

provider "azurerm" {
  use_oidc = true
  features {}
  subscription_id = "${local.environment_vars.locals.subscription_id}"
}
EOF
}

remote_state {
  backend = "azurerm"
  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "${local.environment_vars.locals.resource_group_name}"
    storage_account_name = "${local.environment_vars.locals.storage_account_name}"
    container_name       = "tfstate"
    use_oidc             = true
    subscription_id      = "${local.environment_vars.locals.subscription_id}"
  }
}

