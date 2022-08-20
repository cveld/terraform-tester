module "resourcegroup" {
    source = "../ModuleWithSingleResource"
    #for_each = var.resource_groups
    for_each = {
        for k, v in var.resource_groups: k => v
        if v != null
        # for con in local.network_subnets : "${con.network_key}.${con.subnet_key}" => con
        #if con.type == "private" || con.type == "hybrid"
    }
    resource_group_key = each.key
    resource_group_value = each.value
}