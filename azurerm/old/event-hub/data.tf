data "azurerm_resource_group" "resource_group" {
  name = "rg-${local.suffix}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.suffix}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_private_dns_zone" "pvt_dns_zone" {
  name                = "pvt-dns-zone-${var.environment}.home.where-ever.za.net"
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
}
