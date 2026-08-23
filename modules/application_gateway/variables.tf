variable "app_gateway_name" {
  description = "Name of the Application Gateway."
  type        = string
}

variable "location" {
  description = "Location for the Application Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID dedicated to Application Gateway."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP for Application Gateway."
  type        = string
}

variable "waf_policy_name" {
  description = "Name of the Web Application Firewall Policy."
  type        = string
}

variable "waf_mode" {
  description = "Mode of the WAF Policy (Prevention or Detection)."
  type        = string
  default     = "Prevention"
}

variable "capacity" {
  description = "Capacity / instance count for Application Gateway."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags for Application Gateway resources."
  type        = map(string)
  default     = {}
}
