data "azurerm_client_config" "current" {}

# Create Azure Key Vault using terraform
resource "azurerm_key_vault" "kv" {
  name                            = "kv-${local.suffix}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = azurerm_resource_group.resource_group.location
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = "standard"
  enabled_for_disk_encryption     = false
  enabled_for_deployment          = false
  enabled_for_template_deployment = false
  enable_rbac_authorization       = true
  purge_protection_enabled        = false
  soft_delete_retention_days      = 7

  timeouts {
    delete = "60m"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = var.kv_certificate_permissions_full
    key_permissions         = var.kv_key_permissions_full
    secret_permissions      = var.kv_secret_permissions_full
    storage_permissions     = var.kv_storage_permissions_full
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      access_policy,
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet
  ]
}

# later ? # Create private DNS zone for key vault
# later ? resource "azurerm_private_dns_zone" "pdz_kv" {
# later ?   name                = "privatelink.vaultcore.azure.net"
# later ?   resource_group_name = azurerm_virtual_network.vnet.resource_group_name
# later ?   tags                = local.tags
# later ? 
# later ?   lifecycle {
# later ?     ignore_changes = [
# later ?       tags
# later ?     ]
# later ?   }
# later ?   depends_on = [
# later ?     azurerm_virtual_network.vnet
# later ?   ]
# later ? }
# later ? 
# later ? # Create private virtual network link to spoke vnet
# later ? resource "azurerm_private_dns_zone_virtual_network_link" "kv_pdz_vnet_link" {
# later ?   name                  = "pdz-link-${local.suffix}"
# later ?   resource_group_name   = azurerm_resource_group.resource_group.name
# later ?   virtual_network_id    = azurerm_virtual_network.vnet.id
# later ?   private_dns_zone_name = azurerm_private_dns_zone.pdz_kv.name
# later ? 
# later ?   lifecycle {
# later ?     ignore_changes = [
# later ?       tags
# later ?     ]
# later ?   }
# later ? 
# later ?   depends_on = [
# later ?     azurerm_resource_group.resource_group,
# later ?     azurerm_virtual_network.vnet,
# later ?     azurerm_private_dns_zone.pdz_kv
# later ?   ]
# later ? }
# later ? 
# later ? # Create private endpoint for key vault
# later ? resource "azurerm_private_endpoint" "pe_kv" {
# later ?   name                = "pe-kv-${local.suffix}"
# later ?   location            = azurerm_key_vault.kv.location
# later ?   resource_group_name = azurerm_key_vault.kv.resource_group_name
# later ?   subnet_id           = data.azurerm_subnet.services.id
# later ?   tags                = local.tags
# later ? 
# later ?   private_service_connection {
# later ?     name                           = "pe-${azurerm_key_vault.kv.name}"
# later ?     private_connection_resource_id = azurerm_key_vault.kv.id
# later ?     is_manual_connection           = false
# later ?     subresource_names              = ["vault"]
# later ?   }
# later ? 
# later ?   private_dns_zone_group {
# later ?     name                 = "pdzg-kv-${local.suffix}"
# later ?     private_dns_zone_ids = [azurerm_private_dns_zone.pdz_kv.id]
# later ?   }
# later ? 
# later ?   lifecycle {
# later ?     ignore_changes = [
# later ?       tags
# later ?     ]
# later ?   }
# later ? 
# later ?   depends_on = [
# later ?     azurerm_key_vault.kv,
# later ?     azurerm_private_dns_zone.pdz_kv
# later ?   ]
# later ? }
# later ? 
# later ? #resource "azurerm_key_vault_access_policy" "access_policy_full" {
# later ? #  key_vault_id = azurerm_key_vault.kv.id
# later ? #
# later ? #  tenant_id = data.azurerm_client_config.current.tenant_id
# later ? #  object_id = var.kv_owner_object_id
# later ? #
# later ? #  certificate_permissions = var.kv_certificate_permissions_full
# later ? #  key_permissions         = var.kv_key_permissions_full
# later ? #  secret_permissions      = var.kv_secret_permissions_full
# later ? #  storage_permissions     = var.kv_storage_permissions_full
# later ? #
# later ? #
# later ? #  depends_on = [
# later ? #    azurerm_key_vault.kv
# later ? #  ]
# later ? #}
