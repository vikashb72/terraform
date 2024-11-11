# Create Hub Subnets
resource "azurerm_subnet" "env_snet" {
  for_each                                      = var.env_subnets
  name                                          = format("snet-%s-%s", each.key, local.env.suffix)
  resource_group_name                           = azurerm_resource_group.resource_group.name
  virtual_network_name                          = azurerm_virtual_network.env_vnet.name
  address_prefixes                              = each.value.subnet_address_prefix
  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", null)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.env_vnet
  ]
}

# SNET OUTPUTS
output "env_snet_name" {
  value = [for subnet in azurerm_subnet.env_snet : subnet.name]
}

output "env_snet_id" {
  value = [for subnet in azurerm_subnet.env_snet : subnet.id]
}

output "env_snet_address_prefixes" {
  value = [for subnet in azurerm_subnet.env_snet : subnet.address_prefixes]
}
