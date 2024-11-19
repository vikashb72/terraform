# Create storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account
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

# Create storage container
resource "azurerm_storage_container" "storage_container" {
  for_each              = toset(var.storage_containers)
  name                  = format("sc-%s-%s", each.key, local.suffix)
  storage_account_id    = azurerm_storage_account.storage_account.id
  #storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet,
    azurerm_storage_account.storage_account
  ]
}

# later ? # Create private DNS zone for blob storage account
# later ? resource "azurerm_private_dns_zone" "pdz_storage" {
# later ?   name                = "privatelink.blob.core.windows.net"
# later ?   resource_group_name = azurerm_virtual_network.vnet.resource_group_name
# later ? 
# later ?   tags = local.tags
# later ? 
# later ?   lifecycle {
# later ?     ignore_changes = [
# later ?       tags
# later ?     ]
# later ?   }
# later ? 
# later ?   depends_on = [
# later ?     azurerm_virtual_network.vnet
# later ?   ]
# later ? }
# later ? 
# later ? # Create private virtual network link to vnet
# later ? resource "azurerm_private_dns_zone_virtual_network_link" "sa_pdz_vnet_link" {
# later ?   name                  = "st-pdz-link-${local.suffix}"
# later ?   resource_group_name   = azurerm_resource_group.resource_group.name
# later ?   private_dns_zone_name = azurerm_private_dns_zone.pdz_storage.name
# later ?   virtual_network_id    = azurerm_virtual_network.vnet.id
# later ? 
# later ?   depends_on = [
# later ?     azurerm_virtual_network.vnet,
# later ?     azurerm_private_dns_zone.pdz_storage
# later ?   ]
# later ? }
# later ? 
# later ? # Create Private Endpoint for the Storage Account
# later ? resource "azurerm_private_endpoint" "st_private_endpoint" {
# later ?   name                = "st-private-endpoint-${local.suffix}"
# later ?   resource_group_name = azurerm_resource_group.resource_group.name
# later ?   location            = azurerm_resource_group.resource_group.location
# later ?   subnet_id           = data.azurerm_subnet.storage_snet.id
# later ? 
# later ?   depends_on = [
# later ?     azurerm_virtual_network.vnet,
# later ?     azurerm_private_dns_zone.pdz_storage
# later ?   ]
# later ? 
# later ?   private_service_connection {
# later ?     name                           = "pe-sa-${local.suffix}"
# later ?     private_connection_resource_id = azurerm_storage_account.storage_account.id
# later ?     subresource_names              = ["blob"] 
# later ?     is_manual_connection           = false
# later ?   }
# later ? 
# later ?   private_dns_zone_group {
# later ?     name                 = "pdzg-sa-${local.suffix}"
# later ?     private_dns_zone_ids = [azurerm_private_dns_zone.pdz_storage.id]
# later ?   }
# later ? }
# later ? 
# later ? # Create a DNS Record for the Private Endpoint
# later ? #resource "azurerm_private_dns_a_record" "storage_blob_record" {
# later ? #  name                = "storage-pvt-dns-${var.environment}"
# later ? #  zone_name           = azurerm_private_dns_zone.pvt_dns_zone.name
# later ? #  resource_group_name = azurerm_resource_group.resource_group.name
# later ? #  ttl                 = 300
# later ? #  records             = [azurerm_private_endpoint.storage_account_private_endpoint.private_service_connection[0].private_ip_address]
# later ? #
# later ? #  depends_on = [
# later ? #    azurerm_resource_group.resource_group,
# later ? #    azurerm_virtual_network.vnet,
# later ? #    azurerm_private_endpoint.storage_account_private_endpoint
# later ? #  ]
# later ? #}
