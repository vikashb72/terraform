#resource "azurerm_private_dns_zone" "pvt_dns_zone" {
#  name                = "pvt-dns-zone-${var.environment}.home.where-ever.za.net"
#  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
#
#  lifecycle {
#    ignore_changes = [
#      tags
#    ]
#  }
#
#  depends_on = [
#    azurerm_resource_group.resource_group,
#    azurerm_virtual_network.vnet
#  ]
#}
#
#output "priv_dns_zone_name" {
#  value = azurerm_private_dns_zone.pvt_dns_zone
#}
#
#output "priv_dns_zone_id" {
#  value = azurerm_private_dns_zone.pvt_dns_zone
#}
#
##resource "azurerm_private_dns_a_record" "dns_a_record" {
##  for_each = { for rec in var.dns_records : "${rec.zone_name}-${rec.record_name}" => rec }
##
##  name                = each.value.record_name
##  zone_name           = each.value.zone_name
##  resource_group_name = azurerm_resource_group.rg.name
##  ttl                 = each.value.ttl
##  records             = [each.value.ip]
##  tags                = var.tags
##  depends_on          = [azurerm_private_dns_zone.priv_dns_zone]
##
##}
