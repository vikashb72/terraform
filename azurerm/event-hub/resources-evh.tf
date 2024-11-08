# Event Hub
resource "azurerm_eventhub_namespace" "evhns" {
  name                = "evh-ns-${local.suffix}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku                 = "Basic"
  capacity            = 1 # need confirmation

  tags = local.tags

  depends_on = [
    data.azurerm_resource_group.resource_group,
    data.azurerm_virtual_network.vnet,
    azurerm_subnet.evh_snet
  ]
}

# Create Private Endpoint for the EVH
resource "azurerm_private_endpoint" "evh_private_endpoint" {
  name                = "evh-private-endpoint-${local.suffix}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  subnet_id           = azurerm_subnet.evh_snet.id

  depends_on = [
    data.azurerm_resource_group.resource_group,
    azurerm_subnet.evh_snet,
    azurerm_eventhub_namespace.evhns
  ]

  private_service_connection {
    name                           = "evh-private-connection-${local.suffix}"

    private_connection_resource_id = azurerm_eventhub_namespace.evhns.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
}

# DNS Link
resource "azurerm_private_dns_zone_virtual_network_link" "evh_link_dns_zone_vnet" {
  name                  = "evh-dns-link-${local.suffix}"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  private_dns_zone_name = data.azurerm_private_dns_zone.pvt_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id

  depends_on = [
    data.azurerm_resource_group.resource_group,
    data.azurerm_virtual_network.vnet
  ]
}

## Consumer topic(s)
resource "azurerm_eventhub" "evh" {
  for_each            = { for topic in var.topics: topic.key => topic }
  name                = format("evh-topic-%s-%s", each.key, local.suffix)
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  partition_count     = each.value.partitions # need confirmation
  message_retention   = each.value.retention

  #network_rulesets {
  #  default_action     = "Deny"
  #  trusted_service_access_enabled = true
  #  virtual_network_rule = [
  #    {
  #      subnet_id                                       = ??????
  #      ignore_missing_virtual_network_service_endpoint = false
  #    }
  #  ]
  #}

}

output "evh_topic" {
  value = azurerm_eventhub.evh
}
 
output "evh_topic2" {
  value = [ for c in local.consumers : c ]
}

resource "azurerm_eventhub_consumer_group" "consumer_group" {
  for_each            = local.consumers
  name                = format("evh-cg-%s-%s-%s", each.value.key, each.value.consumer, var.environment)
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = format("gc-topic-%s-%s-%s", each.value.key, each.value.consumer, local.suffix)
  resource_group_name = data.azurerm_resource_group.resource_group.name
  user_metadata       = "initial-terraform"
}

#
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
#resource "azurerm_eventhub_authorization_rule" "evh_listen_role" {
#  name                = "evh-listen-role-${var.environment}-home-where-ever"
#  namespace_name      = azurerm_eventhub_namespace.evhns.name
#  eventhub_name       = azurerm_eventhub.evh.name
#  resource_group_name = data.azurerm_resource_group.resource_group.name
#  listen              = true
#  send                = false
#  manage              = false
#}
#
#resource "azurerm_eventhub_authorization_rule" "evh_send_role" {
#  name                = "evh-send-role-${var.environment}-home-where-ever"
#  namespace_name      = azurerm_eventhub_namespace.evhns.name
#  eventhub_name       = azurerm_eventhub.evh.name
#  resource_group_name = data.azurerm_resource_group.resource_group.name
#  listen              = false
#  send                = true
#  manage              = false
#}
#
#resource "azurerm_eventhub_authorization_rule" "evh_manage_role" {
#  name                = "evh-manage-role-${var.environment}-home-where-ever"
#  namespace_name      = azurerm_eventhub_namespace.evhns.name
#  eventhub_name       = azurerm_eventhub.evh.name
#  resource_group_name = data.azurerm_resource_group.resource_group.name
#  listen              = true
#  send                = true
#  manage              = true
#}

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
