data "azurerm_resource_group" "resource_group" {
  name = "rg-${var.environment}-home-where-ever"
}

data "azurerm_virtual_network" "vnet" {
  name = "vnet-${var.environment}-home.where-ever"
}
