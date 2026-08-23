variable "name" {
  description = "Name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "Location for Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory Tenant ID."
  type        = string
}

variable "sku_name" {
  description = "SKU Name for Key Vault (standard or premium)."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention in days."
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Enable purge protection."
  type        = bool
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Enable RBAC authorization."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for Key Vault."
  type        = map(string)
  default     = {}
}
