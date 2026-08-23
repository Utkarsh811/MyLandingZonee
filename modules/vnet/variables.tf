variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "location" {
  description = "The location of the VNet."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create within the VNet."
  type = map(object({
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string), [])
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool, true)
  }))
}

variable "tags" {
  description = "Tags to assign to the network resources."
  type        = map(string)
  default     = {}
}
