# Enviroment
environment = "hub"

# Location
az_location  = "South Africa North"
country_code = "za"

# Default suffix
suffix = "wherever"

# Virtual Networks
vnets = ["10.1.0.0/19", "fd10:5b10:96b9:1000::/64", "fd10:5b10:96b9:1001::/64"]

# Subnets
snets = {
  "gateway" = {
    "subnet_name"                                    = "gateway"
    "subnet_address_prefix"                          = ["10.1.0.0/26", "fd10:5b10:96b9:1000::/64"]
    "enforce_private_link_endpoint_network_policies" = true
    "enforce_private_link_service_network_policies"  = false
    "delegation"                                     = {}
    "service_endpoints"                              = []
  },
  "services" = {
    "subnet_name"                                    = "services"
    "subnet_address_prefix"                          = ["10.1.1.0/26", "fd10:5b10:96b9:1001::/64"]
    "enforce_private_link_endpoint_network_policies" = true
    "enforce_private_link_service_network_policies"  = false
    "delegation"                                     = {}
    "service_endpoints"                              = []
  }
}

user_assigned_identity = [
  "aks",
  "external-dns",
  "external-secrets",
  "hvault"
]

storage_accounts = [
  {
    key = "cache",
    containers = [ "cache1", "cache2" ]
  },
  {
    key = "mgmt",
    containers = [ "logs", "metrics" ]
  }
]
