# Enviroment
environment         = "lab"

# Location

az_location         = "South Africa North"

# Default suffix
suffix              = "home-wherever"

# Virtual Networks
hub_vnet_subnets    = ["10.0.0.0/20"]
env_vnet_subnets    = ["10.1.0.0/20"]

# Subnets
hub_subnets = {
  "gateway" = {
    "subnet_name"                                    = "gateway",
    "subnet_address_prefix"                          = ["10.0.0.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "services" = {
    "subnet_name"                                    = "services",
    "subnet_address_prefix"                          = ["10.0.1.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "storage" = {
    "subnet_name"                                    = "storage",
    "subnet_address_prefix"                          = ["10.0.2.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = ["Microsoft.Storage"]
  },
  "keyvault" = {
    "subnet_name"                                    = "keyvault",
    "subnet_address_prefix"                          = ["10.0.3.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  }
}

env_subnets = {
  "gateway" = {
    "subnet_name"                                    = "gateway",
    "subnet_address_prefix"                          = ["10.1.0.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "services" = {
    "subnet_name"                                    = "services",
    "subnet_address_prefix"                          = ["10.1.1.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "storage" = {
    "subnet_name"                                    = "storage",
    "subnet_address_prefix"                          = ["10.1.2.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = ["Microsoft.Storage"]
  },
  "keyvault" = {
    "subnet_name"                                    = "keyvault",
    "subnet_address_prefix"                          = ["10.1.3.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "database" = {
    "subnet_name"                                    = "database",
    "subnet_address_prefix"                          = ["10.1.4.0/26"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  }
}

storage_containers = [
  "logs",
  "metrics"
]
