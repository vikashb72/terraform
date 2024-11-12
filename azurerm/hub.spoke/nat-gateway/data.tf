data "azurerm_resource_group" "env_rg" {
  name = "rg-${local.env.suffix}"
}

data "azurerm_virtual_network" "env_vnet" {
  name                = "vnet-${local.env.suffix}"
  resource_group_name = data.azurerm_resource_group.env_rg.name
}
#
#data "azurerm_private_dns_zone" "pvt_dns_zone" {
#  name                = "pvt-dns-zone-${var.environment}.home.where-ever.za.net"  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
#}

output "env_rg" {
   value = data.azurerm_resource_group.env_rg.id
}

output "env_vnet" {
   value = data.azurerm_virtual_network.env_vnet.id
}
