module logicalComponentsModule {
    source = "../../ModuleWithOptionalLogicalComponents"
    optionalComponentEnabled = true
}

terraform {
  backend "local" {}  
}