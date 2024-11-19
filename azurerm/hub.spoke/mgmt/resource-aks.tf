## Create User Assigned Identity used in AKS
#resource "azurerm_user_assigned_identity" "aks_identity" {
#  resource_group_name = azurerm_resource_group.resource_group.name
#  location            = azurerm_resource_group.resource_group.location
#  tags                = local.tags
#
#  name = "aks${var.environment}Identity}"
#
#  lifecycle {
#    ignore_changes = [
#      tags
#    ]
#  }
#}
#
## Create a new Azure Kubernetes Service (Cluster)
#resource "azurerm_kubernetes_cluster" "aks" {
#  name                             = "aks-${local.prefix}"
#  resource_group_name              = azurerm_resource_group.resource_group.name
#  location                         = azurerm_resource_group.resource_group.location
#  kubernetes_version               = var.kubernetes_version
#  dns_prefix                       = "aks-${var.environment}-dns"
#  private_cluster_enabled          = true
#  automatic_channel_upgrade        = false
#  sku_tier                         = "Free"
#  azure_policy_enabled             = true
#  enable_pod_security_policy       = false
#  http_application_routing_enabled = false
#  local_account_disabled           = false // true
#  open_service_mesh_enabled        = false
#
#  linux_profile {
#    admin_username = var.admin_username
#
#    ssh_key {
#      key_data = file("${var.ssh_public_key}")
#    }
#  }
#
#  auto_scaler_profile {
#    balance_similar_node_groups      = false
#    empty_bulk_delete_max            = "10"
#    expander                         = "random"
#    max_graceful_termination_sec     = "600"
#    max_node_provisioning_time       = "15m"
#    max_unready_nodes                = 2
#    max_unready_percentage           = 45
#    new_pod_scale_up_delay           = "0s"
#    scale_down_delay_after_add       = "10m"
#    scale_down_delay_after_delete    = "10s"
#    scale_down_delay_after_failure   = "3m"
#    scale_down_unneeded              = "10m"
#    scale_down_unready               = "20m"
#    scale_down_utilization_threshold = "0.5"
#    scan_interval                    = "10s"
#    skip_nodes_with_local_storage    = false
#    skip_nodes_with_system_pods      = true
#  }
#
#  azure_active_directory_role_based_access_control {
#    admin_group_object_ids = ["3e2ecab0-4fcf-4ae4-98d3-a06c1e842fe8"]
#    tenant_id              = data.azurerm_subscription.current.tenant_id
#    azure_rbac_enabled     = true
#    managed                = true
#  }
#
#  default_node_pool {
#    name       = var.default_node_pool_name
#    node_count = var.default_node_pool_node_count
#    vm_size    = var.default_node_pool_vm_size
#    enable_auto_scaling          = false
#    enable_host_encryption       = false
#    enable_node_public_ip        = false
#    fips_enabled                 = false
#    kubelet_disk_type            = "OS"
#    max_count                    = 1
#    max_pods                     = 20
#    min_count                    = 1
#    node_labels                  = {}
#    node_taints                  = []
#    only_critical_addons_enabled = false
#    os_disk_size_gb              = 128
#    os_sku                       = "Ubuntu"
#    vnet_subnet_id               = azurerm_subnet.aks.id
#  }
#
#  identity {
#    type = "SystemAssigned"
#    # user_assigned_identity_id = azurerm_user_assigned_identity.aks_identity.id
#  }
#
#  #oms_agent {
#  #  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
#  #}
#
#  tags = local.tags
#
#  lifecycle {
#    ignore_changes = [
#      tags,
#      # kube_admin_config,
#      # kube_config,
#      linux_profile,
#      # ingress_application_gateway
#    ]
#  }
#
#  # https://docs.microsoft.com/en-us/azure/aks/use-network-policies
#  network_profile {
#    load_balancer_sku = "standard"
#    network_plugin    = var.network_plugin
#    network_policy    = var.network_policy
#    # outbound_type     = var.outbound_type
#    # pod_cidr           = var.pod_cidr
#    service_cidr       = var.network_service_cidr
#    dns_service_ip     = var.network_dns_service_ip
#    docker_bridge_cidr = var.network_docker_bridge_cidr
#  }
#
#  # ingress_application_gateway {
#  #   gateway_id = azurerm_application_gateway.appgtw.id
#  # }
#
#  key_vault_secrets_provider {
#    secret_rotation_enabled = true
#    # secret_rotation_interval = 2
#  }
#
#  depends_on = [
#    azurerm_log_analytics_workspace.workspace,
#    azurerm_subnet.aks,
#    # azurerm_user_assigned_identity.aks_identity
#    # azurerm_application_gateway.appgtw,
#  ]
#}
#
## Allow AKS Cluster access to Azure Container Registry
#resource "azurerm_role_assignment" "role_acrpull" {
#  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#  role_definition_name             = "AcrPull"
#  scope                            = azurerm_container_registry.acr.id
#  skip_service_principal_aad_check = true
#  depends_on = [
#    azurerm_container_registry.acr,
#    azurerm_kubernetes_cluster.aks
#  ]
#}
#
## dns_zone
## endpoint
