output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "The address space of the Virtual Network."
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnets" {
  description = "Map of subnets created with their details."
  value = {
    for k, s in azurerm_subnet.subnets : k => {
      id               = s.id
      name             = s.name
      address_prefixes = s.address_prefixes
    }
  }
}
