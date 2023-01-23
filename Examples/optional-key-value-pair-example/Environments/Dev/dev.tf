module logicalComponentsModule {
    source = "../../ModuleWithOptionalLogicalComponents"
    optionalComponentEnabled = false
}

terraform {
  backend "local" {}  
}
