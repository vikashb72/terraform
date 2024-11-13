# Create Azure Key Vault using terraform
resource "azurerm_key_vault" "kv" {
  name                            = "kv-wherever-lab-mgmt-${var.environment}-${var.country_code}-01"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = azurerm_resource_group.resource_group.location
  tenant_id                       = var.az_tenant_id
  sku_name                        = var.kv_sku_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  timeouts {
    delete = "60m"
  }

  # network_acls {
  #   bypass                     = var.bypass
  #   default_action             = var.default_action
  #   ip_rules                   = var.ip_rules
  #   virtual_network_subnet_ids = var.virtual_network_subnet_ids
  # }
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

resource "azurerm_key_vault_access_policy" "access_policy_full" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.kv_owner_object_id

  certificate_permissions = var.kv_certificate_permissions_full
  key_permissions         = var.kv_key_permissions_full
  secret_permissions      = var.kv_secret_permissions_full
  storage_permissions     = var.kv_storage_permissions_full


  depends_on = [
    azurerm_key_vault.kv
  ]
}

# Create private DNS zone for key vault
resource "azurerm_private_dns_zone" "pdz_kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
  tags                = local.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create private virtual network link to spoke vnet
resource "azurerm_private_dns_zone_virtual_network_link" "kv_pdz_vnet_link" {
  name                  = "privatelink_to_${azurerm_virtual_network.vnet.name}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.pdz_kv.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet,
    azurerm_private_dns_zone.pdz_kv
  ]
}

# Create private endpoint for key vault
resource "azurerm_private_endpoint" "pe_kv" {
  name                = "endpoint-kv-${local.suffix}"
  location            = azurerm_key_vault.kv.location
  resource_group_name = azurerm_key_vault.kv.resource_group_name
  subnet_id           = data.azurerm_subnet.services.id
  tags                = local.tags

  private_service_connection {
    name                           = "pe-${azurerm_key_vault.kv.name}"    
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "pdzg-kv-${local.suffix}"
    private_dns_zone_ids = [azurerm_private_dns_zone.pdz_kv.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_key_vault.kv,
    azurerm_private_dns_zone.pdz_kv
  ]
}
