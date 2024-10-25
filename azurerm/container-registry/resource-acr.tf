# Create ACR user assigned identity
resource "azurerm_user_assigned_identity" "acr_identity" {  
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  name                = "Identity-acr-${var.environment}-home.where-ever"

  depends_on = [
    azurerm_resource_group.resource_group,
  ]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create the Container Registry
resource "azurerm_container_registry" "acr" {  
  name                    = "acr-${var.environment}-home.where-ever"
  resource_group_name     = azurerm_resource_group.resource_group.name
  location                = azurerm_resource_group.resource_group.location
  sku                     = var.acr_sku
  admin_enabled           = var.acr_admin_enabled
  zone_redundancy_enabled = var.acr_zone_redundancy_enabled
  data_endpoint_enabled   = var.acr_data_endpoint_enabled

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# Create private virtual network link to Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "acr_pdz_vnet_link" {
  name                  = "acr-private-link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns_zone.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet,
    azurerm_private_dns_zone.pvt_dns_zone
  ]
}

# Create private endpoint for Azure container registry
resource "azurerm_private_endpoint" "pe_acr" {  
  name                = "endpoint-acr-${var.environment}-home.where-ever"
  location            = azurerm_container_registry.acr.location
  resource_group_name = azurerm_container_registry.acr.resource_group_name
  subnet_id           = azurerm_subnet.snet_acr.id

  private_service_connection {
    name                           = "pe-${azurerm_container_registry.acr.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = var.pe_acr_subresource_names
    request_message                = try(var.request_message, null)
  }

  private_dns_zone_group {
    name                 = "default" //var.pe_acr_private_dns_zone_group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.pvt_dns_zone.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_container_registry.acr,
    azurerm_private_dns_zone.pvt_dns_zone
  ]
}

# Create acr subnet
resource "azurerm_subnet" "snet_acr" {
  name                                          = "snet-acr-${var.environment}-${var.suffix}"
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.acr_subnet
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
