variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
  default     = "eastus"
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for Key Vault."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "vnet_address_space" {
  description = "Address space for the VNet."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "admin_username" {
  description = "Admin username for virtual machines."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for virtual machines."
  type        = string
  sensitive   = true
  default     = "P@ssw0rd123456!"
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "LandingZone6"
  }
}
