data "azurerm_subnet" "storage_snet" {
  name                 = "snet-storage-${local.env.suffix}"
  virtual_network_name = azurerm_virtual_network.env_vnet.name
  resource_group_name  = azurerm_resource_group.resource_group.name

  depends_on = [
    azurerm_subnet.env_snet
  ]
}
