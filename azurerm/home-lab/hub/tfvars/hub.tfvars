organisation = "wherever"
department   = "home"
project      = "lab"
region       = "southafricanorth"
region_code  = "za"
environment  = "hub"
vnets        = ["10.255.240.0/20", "fd6b:d413:e663::/48"]
snets        = {
  "gateway" = {
    "subnet_address_prefix" = ["10.255.240.0/27", "fd6b:d413:e663:0::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  },
  "firewall" = {
    "subnet_address_prefix" = ["10.255.241.0/27", "fd6b:d413:e663:1::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  },
  "bastion" = {
    "subnet_address_prefix" = ["10.255.242.0/29", "fd6b:d413:e663:2::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  },
  "jumpbox" = {
    "subnet_address_prefix" = ["10.255.243.0/29", "fd6b:d413:e663:3::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  },
  "services" = {
    "subnet_address_prefix" = ["10.255.244.0/27", "fd6b:d413:e663:4::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  },
  "aks" = {
    "subnet_address_prefix" = ["10.255.252.0/22", "fd6b:d413:e663:5::/64"]
    "delegation"            = {}
    "service_endpoints"     = []
  }
}

storage_containers = [
  "tfstate-hub-lab-home-wherever"
]
