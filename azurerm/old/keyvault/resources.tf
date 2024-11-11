data "azurerm_client_config" "current" {}
#
#resource "azurerm_key_vault" "kv" {
#  name                            = "kv-${local.suffix}"
#  location                        = data.azurerm_resource_group.resource_group.location
#  resource_group_name             = data.azurerm_resource_group.resource_group.name
#  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
#  tenant_id                       = data.azurerm_client_config.current.tenant_id
#  soft_delete_retention_days      = 7
#  purge_protection_enabled        = var.purge_protection_enabled
#  sku_name                        = var.kv_sku_name
#  enabled_for_deployment          = var.enabled_for_deployment
#  enabled_for_template_deployment = var.enabled_for_template_deployment
#  enable_rbac_authorization       = var.enable_rbac_authorization
#  purge_protection_enabled        = var.purge_protection_enabled
#  soft_delete_retention_days      = var.soft_delete_retention_days
#
#  access_policy {
#    tenant_id = data.azurerm_client_config.current.tenant_id
#    object_id = data.azurerm_client_config.current.object_id
#
#    certificate_permissions = var.kv_certificate_permissions_full
#    key_permissions         = var.kv_key_permissions_full
#    secret_permissions      = var.kv_secret_permissions_full
#    storage_permissions     = var.kv_storage_permissions_full
#  }
#
#  network_acls {
#    default_action = "Allow"
#    bypass         = "AzureServices"
#
#    # bypass                     = var.bypass
#    # default_action             = var.default_action
#    # ip_rules                   = var.ip_rules
#    # virtual_network_subnet_ids = var.virtual_network_subnet_ids
#  }
#  
#  tags = {
#    environment = var.environment
#  }
#}
#
##resource "azurerm_key_vault_access_policy" "access_policy_full" {
##  key_vault_id = azurerm_key_vault.kv.id
##
##  tenant_id = data.azurerm_client_config.current.tenant_id
##  object_id = var.kv_owner_object_id
##
##  certificate_permissions = var.kv_certificate_permissions_full
##  key_permissions         = var.kv_key_permissions_full
##  secret_permissions      = var.kv_secret_permissions_full
##  storage_permissions     = var.kv_storage_permissions_full
##
##
##  depends_on = [
##    azurerm_key_vault.kv,
##    data.azurerm_client_config.current
##  ]
##}
#
## Create private virtual network link to spoke vnet
#resource "azurerm_private_dns_zone_virtual_network_link" "kv_pdz_vnet_link" {
#  name                  = "kv-dns-link-${azurerm_virtual_network.vnet.name}"
#  resource_group_name   = azurerm_resource_group.vnet.name
#  virtual_network_id    = azurerm_virtual_network.vnet.id
#  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns_zone.name
#
#  lifecycle {
#    ignore_changes = [
#      tags
#    ]
#  }
#  depends_on = [
#    azurerm_resource_group.vnet,
#    azurerm_virtual_network.vnet,
#    azurerm_private_dns_zone.pvt_dns_zone
#  ]
#}
#
## Create private endpoint for key vault
#resource "azurerm_private_endpoint" "pe_kv" {
#  name                = "endpoint-kv-${var.environment}-home.where-ever"
#  location            = azurerm_key_vault.kv.location
#  resource_group_name = azurerm_key_vault.kv.resource_group_name
#  subnet_id           = azurerm_subnet.kv_si.id
#  tags                = merge(local.default_tags, var.kv_tags)
#
#  private_service_connection {
#    name                           = "pe-${azurerm_key_vault.kv.name}"    
#    private_connection_resource_id = azurerm_key_vault.kv.id
#    is_manual_connection           = false
#    subresource_names              = var.pe_kv_subresource_names
#    request_message                = try(var.request_message, null)
#  }
#
#  private_dns_zone_group {
#    name                 = "default" # var.pe_kv_private_dns_zone_group_name
#    private_dns_zone_ids = [azurerm_private_dns_zone.pdz_kv.id]
#  }
#
#  lifecycle {
#    ignore_changes = [
#      tags
#    ]
#  }
#  depends_on = [
#    azurerm_key_vault.kv,
#    azurerm_private_dns_zone.pvt_dns_zone
#  ]
#}
#
## Create keyvault subnet
#resource "azurerm_subnet" "snet_kv" {
#  name                                          = "snet-kv-${var.environment}-${var.suffix}"
#  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
#  virtual_network_name                          = azurerm_virtual_network.vnet.name
#  address_prefixes                              = var.kv_subnet
#  private_endpoint_network_policies             = "Enabled"
#  private_link_service_network_policies_enabled = false
#  depends_on = [
#    azurerm_virtual_network.vnet
#  ]
#}
