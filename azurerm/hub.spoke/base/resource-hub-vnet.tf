# Create Management virtual network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-${local.hub.suffix}"
  address_space       = var.hub_vnet_subnets
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = local.hub.tags

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# VNET OUTPUTS
output "hub_vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_location" {
  value = azurerm_virtual_network.hub_vnet.location
}

output "hub_vnet_address_space" {
  value = azurerm_virtual_network.hub_vnet.address_space
}

output "hub_vnet_subnets" {
  value = azurerm_virtual_network.hub_vnet.subnet
}

output "hub_vnet_dns_servers" {
  value = azurerm_virtual_network.hub_vnet.dns_servers
}
