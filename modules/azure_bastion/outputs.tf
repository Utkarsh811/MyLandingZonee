output "id" {
  description = "ID of the Bastion Host."
  value       = azurerm_bastion_host.bastion.id
}

output "dns_name" {
  description = "FQDN of the Bastion Host."
  value       = azurerm_bastion_host.bastion.dns_name
}

output "public_ip_address" {
  description = "Public IP address allocated to Bastion."
  value       = azurerm_public_ip.bastion_pip.ip_address
}
