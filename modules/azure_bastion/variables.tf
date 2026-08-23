variable "bastion_host_name" {
  description = "Name of the Azure Bastion Host."
  type        = string
}

variable "location" {
  description = "Location for Azure Bastion."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID of AzureBastionSubnet."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP for Azure Bastion."
  type        = string
}

variable "sku" {
  description = "SKU for Azure Bastion (Basic or Standard)."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags for Azure Bastion resources."
  type        = map(string)
  default     = {}
}
