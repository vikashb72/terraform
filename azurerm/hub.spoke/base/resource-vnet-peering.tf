resource "azurerm_virtual_network_peering" "hubtoenv" {
  name                      = "peering-hub-env-${local.env.suffix}"
  resource_group_name       = azurerm_resource_group.resource_group.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.env_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.env_vnet,
  ]
}

resource "azurerm_virtual_network_peering" "envtohub" {
  name                      = "peering-env-hub-${local.env.suffix}"
  resource_group_name       = azurerm_resource_group.resource_group.name
  virtual_network_name      = azurerm_virtual_network.env_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.env_vnet,
  ]
}
