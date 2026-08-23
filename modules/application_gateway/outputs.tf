output "app_gateway_id" {
  description = "ID of the Application Gateway."
  value       = azurerm_application_gateway.appgw.id
}

output "public_ip_address" {
  description = "Public IP address of the Application Gateway."
  value       = azurerm_public_ip.appgw_pip.ip_address
}

output "backend_pool_monolithic_id" {
  description = "ID of Backend Pool 1 (Monolithic App)."
  value       = [for pool in azurerm_application_gateway.appgw.backend_address_pool : pool.id if pool.name == "backend-pool-monolithic"][0]
}

output "backend_pool_supporting_id" {
  description = "ID of Backend Pool 2 (Supporting App)."
  value       = [for pool in azurerm_application_gateway.appgw.backend_address_pool : pool.id if pool.name == "backend-pool-supporting"][0]
}
