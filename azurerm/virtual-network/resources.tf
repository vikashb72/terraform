# Create Management virtual network 
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}-home.where-ever"
  address_space       = var.vnet_subnets
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

# Create Gateway Subnet
resource "azurerm_subnet" "snet_gateway" {
  name                 = "snet-gateway-${var.environment}-home.where-ever"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.gateway_subnet
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create acr subnet
resource "azurerm_subnet" "snet_acr" {
  name                                          = "snet-acr-${var.environment}-home.where-ever"
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.acr_subnet
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create bastion host subnet
#resource "azurerm_subnet" "snet_bastion" {
#  name                                          = "snet-bastion-${var.environment}-home.where-ever"
#  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name                          = azurerm_virtual_network.vnet.name
#  address_prefixes                              = var.bastion_subnet
#  private_endpoint_network_policies_enabled     = false
#  private_link_service_network_policies_enabled = false
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
#
# Create firewall subnet
resource "azurerm_subnet" "snet_firewall" {
#  name                                          = "snet-firewall-${var.environment}-home.where-ever"
#  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name                          = azurerm_virtual_network.vnet.name
#  address_prefixes                              = var.firewall_subnet
#  private_endpoint_network_policies_enabled     = false
#  private_link_service_network_policies_enabled = false
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
# Create psql subnet
resource "azurerm_subnet" "snet_psql" {
#  name                                          = "snet-psql-${var.environment}-home.where-ever"
#  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name                          = azurerm_virtual_network.vnet.name
#  address_prefixes                              = var.firewall_subnet
#  private_endpoint_network_policies_enabled     = false
#  private_link_service_network_policies_enabled = false
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
