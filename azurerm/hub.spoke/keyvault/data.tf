data "azurerm_resource_group" "resource_group" {
  name = "rg-${local.env.suffix}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.env.suffix}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_subnet" "kv_subnet" {
  name = "snet-keyvault-${local.env.suffix}"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_client_config" "current" {}
#
#data "azurerm_private_dns_zone" "pvt_dns_zone" {
#  name                = "pvt-dns-zone-${var.environment}.home.where-ever.za.net"  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
#}

output "env_rg" {
   value = data.azurerm_resource_group.resource_group.id
}

output "env_vnet" {
   value = data.azurerm_virtual_network.vnet.id
}

output "kv_snet" {
   value = data.azurerm_subnet.kv_subnet.id
}

