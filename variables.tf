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
  description = "Name of the Azure Container Registry"
  type        = string
}


variable "sku" {
  description = "ACR SKU"
  type        = string
  default     = "Premium"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard or Premium."
  }
}

variable "admin_enabled" {
  type    = bool
  default = false
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
  type    = number
  default = null
}

variable "enable_identity" {
  type    = bool
  default = false
}

variable "identity_ids" {
  description = "User Assigned Identity IDs"
  type        = list(string)
  default     = null
}

variable "encryption" {
  description = "Customer Managed Key Encryption"

  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })

  default = null
}

variable "georeplications" {
  description = "Geo Replication Configuration"

  type = list(object({
    location                  = string
    regional_endpoint_enabled = optional(bool, true)
    zone_redundancy_enabled   = optional(bool, false)
    tags                      = optional(map(string), {})
  }))

  default = []
}

variable "network_rule_set" {
  description = "List of allowed CIDRs"

  type    = list(string)
  default = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
