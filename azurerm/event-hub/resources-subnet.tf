resource "azurerm_subnet" "evh_snet" {
  name                 = format("snet-evh-%s", local.suffix)
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.evh.subnet_address_prefix
#  address_prefixes     = ["10.0.1.0/24"]
#
#  delegation {
#    name = "delegation"
#
#    service_delegation {
#      name    = "Microsoft.ContainerInstance/containerGroups"
#      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#    }
#  }
}
