#########################################
#Common variables
#########################################

variable "resource_group_name" {
  description = "name of the target resource group resource mask"
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Resource Group."
  type        = string
}


variable "container_registry_name" {
  type        = string
  description = "Name of the Azure Container Registry."
}


variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard or Premium."
  }
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. When enabled, password tokens are generated to be used with docker login. Use Managed Identity or Azure AD authentication instead."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "network_rule_bypass_option" {
  type    = string
  default = "AzureServices"
}

variable "zone_redundancy_enabled" {
  type    = bool
  default = false
}

variable "retention_policy_in_days" {
  description = "Retention policy in days for untagged manifests. If null, this is derived from retention_policy for backward compatibility."
  type        = number
  default     = null
}

variable "enable_identity" {
  description = "Whether to configure a SystemAssigned managed identity on the registry. Defaults to false (least privilege). Set to true only when needed for authentication. When importing an existing registry without identity, keep this as false to avoid unintended in-place assignment."
  type        = bool
  default     = false
}

variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}

variable "identity_ids" {
  description = <<EOT
    Specifies a list of user managed identity ids to be assigned.
    This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`
  EOT
  type        = list(string)
  default     = null
}

variable "encryption" {
  description = "Encrypt registry using a customer-managed key"

  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })

  default = null
}

variable "georeplications" {
  description = "If specified, the ACR will be replicated to other regions specified in this block. Supports both legacy map(object) and list(object) inputs."
  type        = any
  default     = {}
}

variable "network_rule_set" {
  description = <<EOT
    Network rules to explicitly allow IP ranges
    CIDR ranges should be provided
  EOT
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Custom tags for the  container registry"
  type        = map(string)
  default     = {}
}
