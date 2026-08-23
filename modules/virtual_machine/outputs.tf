output "vm_id" {
  description = "ID of the Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "Private IP address of the Virtual Machine NIC."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "nic_id" {
  description = "ID of the Network Interface."
  value       = azurerm_network_interface.nic.id
}
