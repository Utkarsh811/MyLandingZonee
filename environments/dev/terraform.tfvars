environment        = "dev"
location           = "eastus"
vnet_address_space = ["10.0.0.0/16"]
admin_username     = "azureuser"
admin_password     = "P@ssw0rd123456!"

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "LandingZone6"
}
