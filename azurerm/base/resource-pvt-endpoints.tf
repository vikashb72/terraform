#resource "azurerm_private_endpoint" "pep" {
#  for_each            = azurerm_subnet.snet
#  name                = format("pep-%s-%s", each.key, local.suffix)
#  location            = azurerm_resource_group.resource_group.location
#  resource_group_name = azurerm_resource_group.resource_group.name
#  subnet_id           = data.azurerm_subnet.subnet["pvtendpoint"].id
#}
#
#resource "azurerm_subnet" "snet_pvt_endpoint" {
#  name                 = "snet-pvt-endpoint-${local.suffix}"
#  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = var.pvt_endpoint_subnet
#
#  # Delegating subnet to allow for Private Endpoint
#  delegation {
#    name = "private-endpoint-delegation-${local.suffix}"
#    service_delegation {
#      name    = "Microsoft.Network/virtualNetworkGateways"
#      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#    }
#  }
#
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
#resource "azurerm_private_endpoint" "component_sa_pe" {
#  provider            = azurerm.component
#  name                = format("pe-%s", local.component_sa_name)
#  subnet_id           = data.azurerm_subnet.services.id
#
#  private_service_connection {
#    name                           = format("psc-%s", local.component_sa_name)
#    is_manual_connection           = false
#    private_connection_resource_id = resource.azurerm_storage_account.component_sa.id
#    subresource_names              = ["blob"]
#  }
#
#  private_dns_zone_group {
#    name                 = format("pdzg-%s", var.storage_private_dns_zone)
#    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage_pdz.id]
#  }
#
#  # lifecycle {
#  #  prevent_destroy = true
#  #}
#}

#
## Establish the link between private DNS zones and the virtual network.
#resource "azurerm_private_dns_zone_virtual_network_link" "pdnszlink" {
#  for_each              = var.private_endpoints
#  name                  = "link-${each.key}"
#  resource_group_name   = each.value.resource_group_name
#  private_dns_zone_name = azurerm_private_dns_zone.pdnszone[each.key].name
#  virtual_network_id    = data.azurerm_virtual_network.existing[each.key].id
#  tags                  = each.value.tags
#}
#
## Create private endpoints in the specified subnets and connect to the target resources.
#resource "azurerm_private_endpoint" "pep" {
#  for_each            = var.private_endpoints
#  name                = "pep-${each.key}"
#  location            = data.azurerm_resource_group.existing[each.key].location
#  resource_group_name = each.value.resource_group_name
#  subnet_id           = data.azurerm_subnet.existing[each.key].id
#
#  private_service_connection {
#    name                           = "connection-${each.key}"
#    is_manual_connection           = false
#    private_connection_resource_id = each.value.resource_id_to_link
#    subresource_names              = ["vault"]
#  }
#
#  // Link private endpoints to the respective DNS zones.
#  private_dns_zone_group {
#    name                 = "pdnszgroup-${each.key}"
#    private_dns_zone_ids = [azurerm_private_dns_zone.pdnszone[each.key].id]
#  }
#
#  tags = each.value.tags
#}
#
