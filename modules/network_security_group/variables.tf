variable "nsg_name" {
  description = "Name of the Network Security Group."
  type        = string
}

variable "location" {
  description = "Location for the NSG."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "security_rules" {
  description = "List of security rules to apply to the NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "subnet_ids" {
  description = "List of Subnet IDs to associate with this NSG."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the NSG."
  type        = map(string)
  default     = {}
}
