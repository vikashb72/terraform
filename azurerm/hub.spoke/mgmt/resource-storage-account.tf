# Create storage account
resource "azurerm_storage_account" "storage_account" {
  for_each                 = { for sa in var.storage_accounts: sa.key => sa }
  name                     = format("samgmt%s%s%s", each.key, var.environment, var.country_code)
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

# Create private DNS zone for blob storage account
resource "azurerm_private_dns_zone" "pdz_sa" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create private virtual network link to vnet
resource "azurerm_private_dns_zone_virtual_network_link" "pdz_sa_link" {
  name                  = "sa-pdz-link-${local.suffix}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.pdz_sa.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_private_dns_zone.pdz_sa
  ]
}

# Create Private Endpoint for the Storage Account
resource "azurerm_private_endpoint" "sa_private_endpoint" {
  for_each            = { for sa in var.storage_accounts: sa.key => sa }
  name                = format("sa-pe-%s-%s", each.key, local.suffix)
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  subnet_id           = data.azurerm_subnet.services.id

  depends_on = [
    azurerm_virtual_network.vnet,
    data.azurerm_subnet.services,
    azurerm_private_dns_zone.pdz_sa
  ]

  private_service_connection {
    name                           = "pe-sa-${local.suffix}"
    private_connection_resource_id = azurerm_storage_account.storage_account[each.key].id
    subresource_names              = ["blob"] 
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-sa-${local.suffix}"
    private_dns_zone_ids = [azurerm_private_dns_zone.pdz_sa.id]
  }
}

locals {
  containers = merge(
    [ for stg in var.storage_accounts :
      { for container in stg.containers :
        "${stg.key}_${container}" => {
          key      = stg.key
          container = container }
      }
    ]
  ...)
}

# Create storage container
resource "azurerm_storage_container" "storage_container" {
  for_each              = local.containers
  name                  = format("sc-%s-%s-%s", each.value.key, each.value.container, local.suffix)
  storage_account_name  = azurerm_storage_account.storage_account[each.value.key].name
  container_access_type = "private"

  lifecycle {
    # prevent_destroy = false
    prevent_destroy = false
  }

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet
  ]
}

# Create a DNS Record for the Private Endpoint
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
