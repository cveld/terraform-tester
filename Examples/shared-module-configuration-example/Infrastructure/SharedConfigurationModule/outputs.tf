output "specific_configuration" {
  value = {
    key1 = try(var.specific_configuration.key1, var.shared_configuration.key1)
    key2 = try(var.specific_configuration.key2, var.shared_configuration.key2)
  }
}
