resource "random_integer" "cake_pos" {
  max = var.length - 2
  min = 1
}


module "cake_prefix" {
  source = "../.."

  length = random_integer.cake_pos.result
}

module "cake_suffix" {
  source = "../.."

  length = (var.length - 1) - random_integer.cake_pos.result
}
