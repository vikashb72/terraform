# Create Management virtual network
resource "azurerm_virtual_network" "env_vnet" {
  name                = "vnet-${local.env.suffix}"
  address_space       = var.env_vnet_subnets
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = local.env.tags

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# VNET OUTPUTS
output "env_vnet_name" {
  value = azurerm_virtual_network.env_vnet.name
}

output "env_vnet_id" {
  value = azurerm_virtual_network.env_vnet.id
}

output "env_vnet_location" {
  value = azurerm_virtual_network.env_vnet.location
}

output "env_vnet_address_space" {
  value = azurerm_virtual_network.env_vnet.address_space
}

output "env_vnet_subnets" {
  value = azurerm_virtual_network.env_vnet.subnet
}

output "env_vnet_dns_servers" {
  value = azurerm_virtual_network.env_vnet.dns_servers
}
