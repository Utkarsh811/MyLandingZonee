variable "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  type        = string
}

variable "location" {
  description = "Azure Location for NAT Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP for NAT Gateway."
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs to associate with NAT Gateway."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to assign to NAT Gateway resources."
  type        = map(string)
  default     = {}
}
