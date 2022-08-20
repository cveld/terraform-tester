resource "null_resource" testResourceGroup {
    triggers = {
        resource_group_key = var.resource_group_key
        resource_group_value = var.resource_group_value.name
    }
}