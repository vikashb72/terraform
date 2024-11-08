resource "azurerm_storage_account" "storage_account" {
  name                     = "sa0whereever0${var.environment}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet
  ]
}

# Create Private Endpoint for the Storage Account
resource "azurerm_private_endpoint" "storage_account_private_endpoint" {
  name                = "storage-account-private-endpoint-${local.suffix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  subnet_id           = azurerm_subnet.snet["pvtendpoint"].id

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet
  ]

  private_service_connection {
    name                           = "storage-account-pvt-conn-${local.suffix}"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = ["blob"] 
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_link_dns_zone_vnet" {
  name                  = "storage-account-dns-link-${local.suffix}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet,
    azurerm_private_endpoint.storage_account_private_endpoint
  ]
}

## Create a DNS Record for the Private Endpoint
#resource "azurerm_private_dns_a_record" "storage_blob_record" {
#  name                = "storage-pvt-dns-${var.environment}"
#  zone_name           = azurerm_private_dns_zone.pvt_dns_zone.name
#  resource_group_name = azurerm_resource_group.resource_group.name
#  ttl                 = 300
#  records             = [azurerm_private_endpoint.storage_account_private_endpoint.private_service_connection[0].private_ip_address]
#
#  depends_on = [
#    azurerm_resource_group.resource_group,
#    azurerm_virtual_network.vnet,
#    azurerm_private_endpoint.storage_account_private_endpoint
#  ]
#}
#
#
# Create storage container
#resource "azurerm_storage_container" "storage_container" {
#  for_each              = toset(var.storage_account_containers)
#  name                  = format("storage-container-%s-%s", each.key, local.suffix)
#  storage_account_name  = azurerm_storage_account.storage_account.name
#  container_access_type = "private"
#
#  lifecycle {
#    prevent_destroy = true
#  }
#
#  depends_on = [
#    azurerm_resource_group.resource_group,
#    azurerm_virtual_network.vnet,
#    azurerm_storage_account.storage_account
#  ]
#}
