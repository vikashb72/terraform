# Enviroment
environment         = "test"

# Location

az_location         = "South Africa North"

# Default suffix
suffix              = "home-where-ever"

# Virtual Networks
vnet_subnets        = ["10.0.0.0/20"]

# Subnets
subnets = {
  "services" = {
    "subnet_name"                                    = "services",
    "subnet_address_prefix"                          = ["10.0.1.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = []
  },
  "storage" = {
    "subnet_name"                                    = "storage",
    "subnet_address_prefix"                          = ["10.0.2.0/24"],
    "enforce_private_link_endpoint_network_policies" = true,
    "enforce_private_link_service_network_policies"  = false,
    "delegation"                                     = {},
    "service_endpoints"                              = ["Microsoft.Storage"]
  },
  "keyvault" = {
    "subnet_name"                                    = "keyvault",
    "subnet_address_prefix"                          = ["10.0.3.0/24"],
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
