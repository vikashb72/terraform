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

# Create Gateway Subnet
resource "azurerm_subnet" "snet_gateway" {
  name                 = "snet-gateway-${var.environment}-${var.suffix}"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.gateway_subnet
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create acr subnet
resource "azurerm_subnet" "snet_acr" {
  name                                          = "snet-acr-${var.environment}-${var.suffix}"
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.acr_subnet
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create keyvault subnet
resource "azurerm_subnet" "snet_kv" {
  name                                          = "snet-kv-${var.environment}-${var.suffix}"
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.kv_subnet
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
