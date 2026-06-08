resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = var.sku
  admin_enabled = var.admin_enabled

  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  retention_policy_in_days      = var.sku == "Premium" ? var.retention_policy_in_days : null
  # Managed Identity
  dynamic "identity" {
    for_each = var.identity_ids != null ? [1] : var.enable_identity ? [1] : []

    content {
      type = var.identity_ids != null ? "UserAssigned" : "SystemAssigned"

      identity_ids = var.identity_ids
    }
  }

  # Customer Managed Key Encryption
  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []

    content {
      key_vault_key_id   = encryption.value.key_vault_key_id
      identity_client_id = encryption.value.identity_client_id
    }
  }

  # Geo Replications
  dynamic "georeplications" {
    for_each = var.sku == "Premium" ? var.georeplications : []

    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, true)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, false)

      tags = try(georeplications.value.tags, {})
    }
  }

  # Network Rules
  dynamic "network_rule_set" {
    for_each = (
      var.sku == "Premium" &&
      length(var.network_rule_set) > 0
    ) ? [1] : []

    content {
      default_action = "Deny"

      dynamic "ip_rule" {
        for_each = var.network_rule_set

        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }

  tags = local.tags

  lifecycle {
    precondition {
      condition = (
        var.encryption == null ||
        length(coalesce(var.identity_ids, [])) > 0
      )

      error_message = "When encryption is configured, at least one User Assigned Identity must be provided."
    }
  }
}
