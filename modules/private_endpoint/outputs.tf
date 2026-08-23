output "id" {
  description = "ID of the Private Endpoint."
  value       = azurerm_private_endpoint.pe.id
}

output "private_ip_address" {
  description = "Private IP address allocated to the Private Endpoint."
  value       = azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address
}

output "dns_zone_id" {
  description = "ID of the Private DNS Zone."
  value       = azurerm_private_dns_zone.dns_zone.id
}
