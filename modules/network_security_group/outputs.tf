output "nsg_id" {
  description = "ID of the created NSG."
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "Name of the created NSG."
  value       = azurerm_network_security_group.nsg.name
}
