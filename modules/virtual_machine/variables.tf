variable "vm_name" {
  description = "Name of the Virtual Machine."
  type        = string
}

variable "location" {
  description = "Location for the Virtual Machine."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the NIC will be attached."
  type        = string
}

variable "size" {
  description = "Size of the Virtual Machine."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the VM."
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM (used if SSH key is not provided)."
  type        = string
  sensitive   = true
  default     = null
}

variable "ssh_public_key" {
  description = "SSH public key content for authentication."
  type        = string
  default     = null
}

variable "app_gateway_backend_pool_id" {
  description = "Optional Application Gateway Backend Address Pool ID to associate with the VM NIC."
  type        = string
  default     = null
}

variable "attach_to_application_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  description = "Tags for VM resources."
  type        = map(string)
  default     = {}
}
