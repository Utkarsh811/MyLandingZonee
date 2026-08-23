output "nat_gateway_id" {
  description = "ID of the NAT Gateway."
  value       = azurerm_nat_gateway.nat.id
}

output "public_ip_address" {
  description = "Public IP address allocated for the NAT Gateway."
  value       = azurerm_public_ip.nat_pip.ip_address
}
