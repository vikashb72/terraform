resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}-home.where-ever"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
