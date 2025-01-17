// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "random_integer" "priority" {
  min = 10000
  max = 50000
}

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 2.0"

  for_each = var.resource_names_map

  logical_product_family  = var.product_family
  logical_product_service = var.product_service
  region                  = var.region
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  maximum_length          = each.value.max_length
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = module.resource_names["rg"].dns_compliant_minimal_random_suffix
  location = var.region

  tags = merge(var.tags, { resource_name = module.resource_names["rg"].standard })

}

module "container_registry" {
  depends_on                    = [module.resource_group]
  source                        = "../../"
  container_registry_name       = module.resource_names["rg"].lower_case_without_any_separators
  resource_group_name           = module.resource_group.name
  location                      = var.region
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled

  tags = merge(var.tags, { resource_name = module.resource_names["acr"].standard })
}
