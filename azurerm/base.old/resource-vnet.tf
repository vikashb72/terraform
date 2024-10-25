# Create Management virtual network 
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}-${var.suffix}"
  address_space       = var.vnet_subnets
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# Create Subnet for Private Endpoint
resource "azurerm_subnet" "snet_pvt_endpoint" {
  name                 = "snet-pvt-endpoint-${var.environment}-${var.suffix}"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pvt_endpoint_subnet

  # Delegating subnet to allow for Private Endpoint
  delegation {
    name = "private-endpoint-delegation-${var.environment}-${var.suffix}"
    service_delegation {
      name    = "Microsoft.Network/virtualNetworkGateways"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create Gateway Subnet
#resource "azurerm_subnet" "snet_gateway" {
#  name                 = "snet-gateway-${var.environment}-${var.suffix}"
#  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = var.gateway_subnet
#
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
#
## Create Storage Subnet
#resource "azurerm_subnet" "snet_storage" {
#  name                 = "snet-storage-${var.environment}-${var.suffix}"
#  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = var.storage_subnet
#
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
