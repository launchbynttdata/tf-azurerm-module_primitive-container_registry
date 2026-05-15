<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | name of the target resource group resource mask | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group. | `string` | n/a | yes |
| <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name) | Container Registry name. | `string` | `"nexientacr000"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium. | `string` | `"Basic"` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled. Defaults to true. When enabled, password tokens are generated to be used with docker login | `bool` | `true` | no |
| <a name="input_enable_identity"></a> [enable\_identity](#input\_enable\_identity) | Whether to enable a system-assigned managed identity when no user-assigned identities are provided. | `bool` | `false` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Set a retention policy for untagged manifests | <pre>object({<br/>    days    = optional(number)<br/>    enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned.<br/>    This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned` | `list(string)` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encrypt registry using a customer-managed key | <pre>object({<br/>    key_vault_key_id   = string<br/>    identity_client_id = string<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_network_rule_bypass_option"></a> [network\_rule\_bypass\_option](#input\_network\_rule\_bypass\_option) | Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are<br/>    None and AzureServices. Defaults to AzureServices | `string` | `"AzureServices"` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created.<br/>    Defaults to false | `bool` | `false` | no |
| <a name="input_georeplications"></a> [georeplications](#input\_georeplications) | If specified, the ACR will be replicated to other regions specified in this block | <pre>map(object({<br/>    location                  = string<br/>    regional_endpoint_enabled = bool<br/>    zone_redundancy_enabled   = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | Network rules to explicitly allow IP ranges<br/>    CIDR ranges should be provided | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the  container registry | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the Container Registry |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | The login server of the Container Registry |
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | Name of the Container Registry |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | The admin username of the Container Registry |
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | The admin password of the Container Registry |
| <a name="output_container_registry_admin_enabled"></a> [container\_registry\_admin\_enabled](#output\_container\_registry\_admin\_enabled) | The admin enable of the Container Registry |
<!-- END_TF_DOCS -->
