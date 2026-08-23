variable "name" {
  description = "Name of the Private Endpoint."
  type        = string
}

variable "location" {
  description = "Location of the Private Endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the Private Endpoint will be created."
  type        = string
}

variable "target_resource_id" {
  description = "ID of the target resource (e.g. Key Vault)."
  type        = string
}

variable "subresource_names" {
  description = "Subresource names for the connection (e.g. ['vault'])."
  type        = list(string)
}

variable "vnet_id" {
  description = "Virtual Network ID for Private DNS Zone link."
  type        = string
}

variable "dns_zone_name" {
  description = "Name of the Private DNS Zone (e.g. privatelink.vaultcore.azure.net)."
  type        = string
}

variable "tags" {
  description = "Tags for Private Endpoint."
  type        = map(string)
  default     = {}
}
