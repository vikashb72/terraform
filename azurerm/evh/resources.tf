resource "azurerm_eventhub_namespace" "evhns" {
  name                = "evhns-${var.environment}-home-where-ever"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku                 = "Basic"
  capacity            = 1

  tags = {
    environment = var.environment
  }
}

resource "azurerm_eventhub" "evh" {
  name                = "evh-${var.environment}-home-where-ever"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  partition_count     = 1
  message_retention   = 1
}

#resource "azurerm_eventhub_authorization_rule" "auth" {
#  name                = "navi"
#  namespace_name      = azurerm_eventhub_namespace.evh_namespace.name
#  eventhub_name       = azurerm_eventhub.evh.name
#  resource_group_name = data.azurerm_resource_group.resource_group.name
#  listen              = true
#  send                = false
#  manage              = false
#}
#
#resource "azurerm_role_assignment" "pod-identity-assignment" {
#  scope                = data.azurerm_resource_group.resourceGroup.id
#  role_definition_name = "Azure Event Hubs Data Owner"
#  principal_id         = ""
#}

