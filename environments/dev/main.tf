# 1. Resource Group Module
module "resource_group" {
  source   = "../../modules/resource_group"
  name     = "rg-${var.environment}-landingzone6"
  location = var.location
  tags     = var.tags
}

# 2. Virtual Network & Subnets Module
module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "vnet-${var.environment}-landingzone6"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  tags                = var.tags

  subnets = {
    "snet-appgw" = {
      address_prefixes = ["10.0.1.0/24"]
    }
    "snet-monolithic" = {
      address_prefixes = ["10.0.2.0/24"]
    }
    "snet-supporting" = {
      address_prefixes = ["10.0.3.0/24"]
    }
    "AzureBastionSubnet" = {
      address_prefixes = ["10.0.4.0/24"]
    }
    "snet-private-endpoint" = {
      address_prefixes = ["10.0.5.0/24"]
    }
  }
}

# 3. Network Security Groups
module "nsg_appgw" {
  source              = "../../modules/network_security_group"
  nsg_name            = "nsg-${var.environment}-appgw"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_ids          = [module.vnet.subnets["snet-appgw"].id]
  tags                = var.tags

  security_rules = [
    {
      name                       = "Allow-HTTPS-Inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP-Inbound"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-GatewayManager-Inbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "65200-65535"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
    }
  ]
}

module "nsg_vms" {
  source              = "../../modules/network_security_group"
  nsg_name            = "nsg-${var.environment}-vms"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_ids = [
    module.vnet.subnets["snet-monolithic"].id,
    module.vnet.subnets["snet-supporting"].id
  ]
  tags = var.tags

  security_rules = [
    {
      name                       = "Allow-AppGateway-Inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-Bastion-SSH"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.4.0/24"
      destination_address_prefix = "*"
    }
  ]
}

# 4. NAT Gateway Module
module "nat_gateway" {
  source              = "../../modules/nat_gateway"
  nat_gateway_name    = "natgw-${var.environment}-landingzone6"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  public_ip_name      = "pip-natgw-${var.environment}"
  subnet_ids = [
    module.vnet.subnets["snet-monolithic"].id,
    module.vnet.subnets["snet-supporting"].id
  ]
  tags = var.tags
}

# 5. Application Gateway WAF_v2 Module
module "application_gateway" {
  source              = "../../modules/application_gateway"
  app_gateway_name    = "appgw-${var.environment}-landingzone6"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.vnet.subnets["snet-appgw"].id
  public_ip_name      = "pip-appgw-${var.environment}"
  waf_policy_name     = "wafpol-${var.environment}-landingzone6"
  waf_mode            = "Prevention"
  capacity            = 2
  tags                = var.tags
}

# 6. Virtual Machines (4 VMs total)
module "vm01" {
  source                        = "../../modules/virtual_machine"
  vm_name                       = "vm01-monolithic-${var.environment}"
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  subnet_id                     = module.vnet.subnets["snet-monolithic"].id
  size                          = "Standard_B2s"
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  app_gateway_backend_pool_id   = module.application_gateway.backend_pool_monolithic_id
  tags                          = var.tags
  attach_to_application_gateway = true
}

module "vm02" {
  source                        = "../../modules/virtual_machine"
  vm_name                       = "vm02-monolithic-${var.environment}"
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  subnet_id                     = module.vnet.subnets["snet-monolithic"].id
  size                          = "Standard_B2s"
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  app_gateway_backend_pool_id   = module.application_gateway.backend_pool_monolithic_id
  tags                          = var.tags
  attach_to_application_gateway = true
}

module "vm03" {
  source                        = "../../modules/virtual_machine"
  vm_name                       = "vm03-supporting-${var.environment}"
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  subnet_id                     = module.vnet.subnets["snet-supporting"].id
  size                          = "Standard_B2s"
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  app_gateway_backend_pool_id   = module.application_gateway.backend_pool_supporting_id
  tags                          = var.tags
  attach_to_application_gateway = true
}

module "vm04" {
  source                        = "../../modules/virtual_machine"
  vm_name                       = "vm04-supporting-${var.environment}"
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  subnet_id                     = module.vnet.subnets["snet-supporting"].id
  size                          = "Standard_B2s"
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  app_gateway_backend_pool_id   = module.application_gateway.backend_pool_supporting_id
  tags                          = var.tags
  attach_to_application_gateway = true
}

# 7. Azure Bastion Module
module "azure_bastion" {
  source              = "../../modules/azure_bastion"
  bastion_host_name   = "bastion-${var.environment}-landingzone6"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.vnet.subnets["AzureBastionSubnet"].id
  public_ip_name      = "pip-bastion-${var.environment}"
  sku                 = "Standard"
  tags                = var.tags
}

# 8. Key Vault Module
module "key_vault" {
  source                     = "../../modules/key_vault"
  name                       = "kv-${var.environment}-lz6-vault"
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  enable_rbac_authorization  = true
  tags                       = var.tags
}

# 9. Private Endpoint Module
module "private_endpoint_kv" {
  source              = "../../modules/private_endpoint"
  name                = "pe-kv-${var.environment}-landingzone6"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.vnet.subnets["snet-private-endpoint"].id
  target_resource_id  = module.key_vault.id
  subresource_names   = ["vault"]
  vnet_id             = module.vnet.vnet_id
  dns_zone_name       = "privatelink.vaultcore.azure.net"
  tags                = var.tags
}
