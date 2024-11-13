# Services Subnet Reference Data
data "azurerm_subnet" "services" {
  name                 = format("snet-services-%s", local.suffix)
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.resource_group.name

  depends_on = [
    azurerm_subnet.snet
  ]
}

data "azurerm_client_config" "current" {}
