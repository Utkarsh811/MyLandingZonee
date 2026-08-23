output "resource_group_name" {
  description = "The name of the deployed resource group."
  value       = module.resource_group.name
}

output "application_gateway_public_ip" {
  description = "The Public IP address of the Application Gateway."
  value       = module.application_gateway.public_ip_address
}

output "nat_gateway_public_ip" {
  description = "The Public IP address of the NAT Gateway."
  value       = module.nat_gateway.public_ip_address
}

output "bastion_public_ip" {
  description = "The Public IP address of the Azure Bastion host."
  value       = module.azure_bastion.public_ip_address
}

output "bastion_dns_name" {
  description = "The FQDN of the Azure Bastion host."
  value       = module.azure_bastion.dns_name
}

output "vm_private_ips" {
  description = "Private IP addresses for deployed virtual machines."
  value = {
    vm01_monolithic = module.vm01.private_ip_address
    vm02_monolithic = module.vm02.private_ip_address
    vm03_supporting = module.vm03.private_ip_address
    vm04_supporting = module.vm04.private_ip_address
  }
}

output "key_vault_uri" {
  description = "URI of the deployed Key Vault."
  value       = module.key_vault.vault_uri
}

output "key_vault_private_ip" {
  description = "Private IP address of the Key Vault Private Endpoint."
  value       = module.private_endpoint_kv.private_ip_address
}
