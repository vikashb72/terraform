# Create Management virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.suffix}"
  address_space       = var.vnet_subnets
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = local.tags

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# OUTPUTS

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_location" {
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_subnets" {
  value       = azurerm_virtual_network.vnet.subnet
}

output "vnet_dns_servers" {
  value       = azurerm_virtual_network.vnet.dns_servers
}
