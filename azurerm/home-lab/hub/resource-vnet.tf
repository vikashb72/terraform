# Create Management virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.suffix}"
  address_space       = var.vnets
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = local.tags

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# VNET OUTPUTS
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
