output "output" {
  value = {
    module1output = module.Module1.output
    module2output = module.Module2.output
  }
}
