product_service               = "ex"
environment_number            = "005"
public_network_access_enabled = true
admin_enabled                 = true


tags = {
  provisioner = "Terraform"
  purpose     = "Terratest for public ACR"
}

# Default behavior (enable_identity = true) preserves SystemAssigned identity
enable_identity = true
