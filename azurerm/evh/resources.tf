resource "azurerm_eventhub_namespace" "evhns" {
  name                = "evhns-${var.environment}-home-where-ever"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku                 = "Basic"
  capacity            = 1 # need confirmation

  tags = {
    environment = var.environment
  }
}

resource "azurerm_eventhub" "evh" {
  name                = "evh-${var.environment}-home-where-ever"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  partition_count     = 1 # need confirmation
  message_retention   = 1

  network_rulesets {
    default_action     = "Deny"
    trusted_service_access_enabled = true
    virtual_network_rule = [
      {
        subnet_id                                       = ??????
        ignore_missing_virtual_network_service_endpoint = false
      }
    ]
  }
}

# Create azure event hub namespace diagnostic settings using terraform
#resource "azurerm_monitor_diagnostic_setting" "evh_diag" {
#  name                       = "evh-diag-${var.environment}-home-where-ever"
#  target_resource_id         = azurerm_eventhub_namespace.evh.id
#  #log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
#  enabled_log {
#    category_group = "allLogs"
#
#    retention_policy {
#      days    = 0
#      enabled = false
#    }
#  }
#  enabled_log {
#    category_group = "audit"
#
#    retention_policy {
#      days    = 0
#      enabled = false
#    }
#  }
#
#  metric {
#    category = "AllMetrics"
#    enabled  = true
#
#    # retention_policy {
#    #   enabled = true
#    #   days    = 30
#    # }
#  }
#  lifecycle {
#    ignore_changes = [
#      # enabled_log
#    ]
#  }
#
#  depends_on = [
#    azurerm_eventhub_namespace.evh
#  ]
#}

# Roles
resource "azurerm_eventhub_authorization_rule" "evh_listen_role" {
  name                = "evh-listen-role-${var.environment}-home-where-ever"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.evh.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  listen              = true
  send                = false
  manage              = false
}

resource "azurerm_eventhub_authorization_rule" "evh_send_role" {
  name                = "evh-send-role-${var.environment}-home-where-ever"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.evh.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_eventhub_authorization_rule" "evh_manage_role" {
  name                = "evh-manage-role-${var.environment}-home-where-ever"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.evh.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  listen              = true
  send                = true
  manage              = true
}


# What exactly are these
#resource "azurerm_eventhub_consumer_group" "cg_1" {
#  name                = "evh-consumer-group-${var.environment}-home-where-ever"
#  namespace_name      = azurerm_eventhub_namespace.evhns.name
#  eventhub_name       = azurerm_eventhub.evh.name
#  resource_group_name = data.azurerm_resource_group.resource_group.name
#  user_metadata       = "some-meta-data"
#}
#
#resource "azurerm_role_assignment" "pod-identity-assignment" {
#  scope                = data.azurerm_resource_group.resourceGroup.id
#  role_definition_name = "Azure Event Hubs Data Owner"
#  principal_id         = ""
#}
