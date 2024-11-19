# Create ACR user assigned identity
resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  tags = local.tags
  name = "acr${var.environment}Identity"

  depends_on = [
    azurerm_resource_group.resource_group
  ]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create the Container Registry
resource "azurerm_container_registry" "acr" {
  name                  = azurerm_user_assigned_identity.acr_identity.name
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = azurerm_resource_group.resource_group.location
  sku                   = "Basic"
  admin_enabled         = false
  #data_endpoint_enabled = true

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

# Create private DNS zone for Azure container registry
resource "azurerm_private_dns_zone" "pdz_acr" {
  name                = "privatelink.azurecr.io"
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

# Create private virtual network link to Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "acr_pdz_vnet_link" {
  name                  = "acr-pdz-link-${local.suffix}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.pdz_acr.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.vnet,
    azurerm_private_dns_zone.pdz_acr
  ]
}
