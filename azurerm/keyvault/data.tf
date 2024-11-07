data "azurerm_resource_group" "resource_group" {
  name = "rg-${local.suffix}"
}

data "azurerm_virtual_network" "vnet" {
  name  = "vnet-${local.suffix}"
  #resource_group_name = "rg-${local.suffix}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_subnet" "kv_subnet" {
  name = "snet-keyvault-${local.suffix}"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_private_dns_zone" "pvt_dns_zone" {
  name                = "pvt-dns-zone-${var.environment}.home.where-ever.za.net"
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
}

#keyvault

output "rg" {
   value = data.azurerm_resource_group.resource_group.name
}

#output "vnet" {
#   value = data.azurerm_virtual_network.vnet.subnets
#}

output "kv_snet" {
   value = data.azurerm_subnet.kv_subnet.id
}

output "pvt_dns_zone" {
  value = data.azurerm_private_dns_zone.pvt_dns_zone.name
}

