locals {
  default_tags = {
    provisioner = "terraform"
    resource_name = var.container_registry_name
  }
  tags = merge(local.default_tags, var.tags)
}
