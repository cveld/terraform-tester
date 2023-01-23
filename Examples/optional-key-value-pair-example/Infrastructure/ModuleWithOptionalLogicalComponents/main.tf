module mymodule {
    source = "../ModuleWithForeachLoops"
    resource_groups = {
        "rg1": {
            "name": "coreResourceGroup"
        },
        "rg2": (var.optionalComponentEnabled ? {
            "name": "optionalResourceGroup"
        } : null)
        
    }
}

locals {

}