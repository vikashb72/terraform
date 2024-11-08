# Enviroment
environment         = dev

# Location

az_location         = "South Africa North"

# Default suffix
suffix              = "home-where-ever"

# Virtual Networks
# Management
vnet_subnets        = ["10.1.0.0/20"]

subnets = {
  "management" = {
    "subnet_name"                                    = "management",
    "subnet_address_prefix"                          = ["10.1.0.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "storage" = {
    "subnet_name"                                    = "storage-01",
    "subnet_address_prefix"                          = ["10.1.1.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = ["Microsoft.Storage"]
  },
  #"aksnodepool01" = {
  #  "subnet_name"                                    = "aks-nodepool-01",
  #  "subnet_address_prefix"                          = ["10.1.2.0/24"],
  #  "enforce_private_link_endpoint_network_policies" = true,
  #  "enforce_private_link_service_network_policies"  = false,
  #  "delegation"                                     = {},
  #  "service_endpoints"                              = []
  #},
  "keyvault" = {
    "subnet_name"                                    = "keyvault",
    "subnet_address_prefix"                          = ["10.1.3.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  #"acr" = {
  #  "subnet_name"                                    = "acr",
  #  "subnet_address_prefix"                          = ["10.1.4.0/24"],
  #  "enforce_private_link_endpoint_network_policies" = true,
  #  "enforce_private_link_service_network_policies"  = false,
  #  "delegation"                                     = {},
  #  "service_endpoints"                              = []
  #},
  #"services" = {
  #  "subnet_name"                                    = "services",
  #  "subnet_address_prefix"                          = ["10.1.5.0/24"],
  #  "enforce_private_link_endpoint_network_policies" = true,
  #  "enforce_private_link_service_network_policies"  = false,
  #  "delegation"                                     = {},
  #  "service_endpoints"                              = []
  #},
  "pvtendpoint" = {
    "subnet_name"                                    = "pvt-endpoint",
    "subnet_address_prefix"                          = ["10.1.6.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  }
}

storage_account_containers = [
  "terraform-state",
  "logs"
]
