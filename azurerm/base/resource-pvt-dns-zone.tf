resource "azurerm_private_dns_zone" "pvt_dns_zone" {
  name                = "pvt-dns-zone-${var.environment}-home.where-ever"
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
