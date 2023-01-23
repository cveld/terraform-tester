# Examples
This repo contains a variety of Terraform examples:
* Azure storage account firewall whitelisting
* Optional key value pair
* shared-module-configuration-example

## Azure storage account firewall whitelisting
### Context
When running data plane operations through your GitHub workflow on a public runner against a firewall protected resource, you will run into a 403 access denied.
You will want to whitelist your client ip temporarily.

Unfortunately the `azurerm` provider does not provide out of the box means to temporarily open up the firewall.
Additionally, Terraform does not provide straight means to perform any upfront activities. Through the local provisioner feature you are able to run custom scripts, but these are only performed _after_ the provider has provisioned the resource.
And lastly, if refreshing of resources is enabled, your client ip must be whitelisted before you kick off Terraform or else you will get the 403 access denied error already during refreshing.

Therefore, we will need to use a combination of mitigations to get it done:
1. Whitelist your client ip - we will check if the storage account already exists, and if so, we will whitelist your client ip
2. Use a local provisioner to kick off the whitelisting _after_ the storage account is provisioned and _before_ the data plane operations kick off
3. Finally, remove your client ip from the storage account.

### Parsing of Terraform state file
Instead of hardcoding the resource reference in Step 1 and 3 we utilize a path into the Terraform state file. With PowerShell we parse the Terraform statefile and look up the resource reference dynamically.

### Source code
Source code can be found in the following folder: /azure-storageaccount-firewall-whitelist-example (d)[d]   [ab](/azure-storageaccount-firewall-whitelist-example)


## Optional key value pair
Hashicorp Configuration Language does not seem to provide means to optionally specify a key value pair in an object. In this example we will always set the input key, but with an optional null value. Then, in our infrastructure module we will skip null values.

## Shared module configuration example
When you have a list of modules that share some core configuration set, you can provide this core configuration set to the various modules. Then, inside the module, you can check if a specific setting is available, and if not, you can fall back on the value from the core configuration set.

# Folder structure
This repo applies the following folder structure:
* _Scripts_: contains scripts
* _Tests_: contains tests to run the scripts
* _Examples_: contains the examples
* Example folder: 
  * _Environments_: contains folders per environment
  * _Infrastructure_: contains the infrastructure configuration