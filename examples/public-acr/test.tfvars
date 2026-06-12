product_service    = "ex"
environment_number = "0005"

public_network_access_enabled = true
admin_enabled                 = true
enable_identity               = true

tags = {
  provisioner = "Terraform"
  purpose     = "Terratest for public ACR"
}
