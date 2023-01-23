output "specific_configuration" {
  value = {
    key1 = try(var.specific_configuration.key1, local.default.key1)
    key2 = try(var.specific_configuration.key2, local.default.key2)
  }
}
